#!/usr/bin/env python3
"""
Upload GitHubusercontent PNGs referenced by skins.json to Roblox Open Cloud as Image assets.

Features:
- Parses skins.json to extract raw.githubusercontent.com PNG URLs
- Downloads images (with retries)
- Uploads to Roblox Open Cloud (POST /v1/assets) and polls operation until done
- Global rate limiting for all Open Cloud requests (default 50 rpm, configurable)
- Persistent state to skip already-processed URLs and avoid re-uploads
- Incremental: only processes new/changed URLs since last run

Docs: https://create.roblox.com/docs/reference/cloud/assets/v1#POST-v1-assets
"""

from __future__ import annotations

import argparse
import concurrent.futures
import contextlib
import dataclasses
import hashlib
import json
import os
import queue
import re
import sys
import threading
import time
from pathlib import Path
from typing import Dict, Iterable, List, Optional, Set, Tuple

import requests

try:
    from dotenv import load_dotenv  # type: ignore
except Exception:  # pragma: no cover
    load_dotenv = None  # noqa: N816


# ------------------------------ Constants ----------------------------------

GITHUB_RAW_HOST = "raw.githubusercontent.com"
PNG_REGEX = re.compile(r"https://raw\.githubusercontent\.com/[^\s\"]+?\.png")

ROBLOX_API_BASE = "https://apis.roblox.com"
ROBLOX_ASSETS_CREATE = f"{ROBLOX_API_BASE}/assets/v1/assets"
ROBLOX_ASSETS_OPERATION = f"{ROBLOX_API_BASE}/assets/v1/operations/{{operation_id}}"

DEFAULT_STATE_DIR = ".state"
DEFAULT_STATE_FILE = "skins_image_uploads.json"

DEFAULT_RPM = 50  # Safe under the documented 60 req/min account-wide


# ------------------------------ Utilities ----------------------------------

def sha256_bytes(data: bytes) -> str:
    hasher = hashlib.sha256()
    hasher.update(data)
    return hasher.hexdigest()


def ensure_dir(path: Path) -> None:
    path.mkdir(parents=True, exist_ok=True)


def extract_display_name_from_url(url: str) -> str:
    """Return the base filename without the last .png extension.

    Example: /crate_community_21_png.png -> crate_community_21_png
    """
    filename = url.rstrip("/").split("/")[-1]
    if filename.lower().endswith(".png"):
        return filename[: -len(".png")]
    return Path(filename).stem


def iter_png_urls_from_json(data: object) -> Iterable[str]:
    """Traverse arbitrary JSON, yielding every matching GitHub raw PNG URL."""
    if isinstance(data, dict):
        for value in data.values():
            yield from iter_png_urls_from_json(value)
    elif isinstance(data, list):
        for item in data:
            yield from iter_png_urls_from_json(item)
    elif isinstance(data, str):
        if data.startswith("https://") and GITHUB_RAW_HOST in data and data.lower().endswith(".png"):
            yield data


def load_urls_from_skins_json(skins_json_path: Path) -> List[str]:
    """Load and parse skins.json, extracting unique GitHub raw PNG URLs.

    Falls back to regex scanning if JSON parsing fails.
    """
    text = skins_json_path.read_text(encoding="utf-8")
    urls: Set[str] = set()
    with contextlib.suppress(Exception):
        parsed = json.loads(text)
        for url in iter_png_urls_from_json(parsed):
            urls.add(url)
        if urls:
            return sorted(urls)

    # Fallback: regex scan
    for match in PNG_REGEX.finditer(text):
        urls.add(match.group(0))
    return sorted(urls)


# ------------------------------ Rate Limiter -------------------------------

class TokenBucket:
    """Simple token bucket limiter for requests per minute.

    Thread-safe. Sleeps when tokens are not available.
    """

    def __init__(self, rate_per_minute: int) -> None:
        self.capacity = max(1, rate_per_minute)
        self.tokens = self.capacity
        self.refill_interval = 60.0 / float(self.capacity)
        self.lock = threading.Lock()
        self.last_refill = time.monotonic()

    def acquire(self) -> None:
        while True:
            with self.lock:
                now = time.monotonic()
                # Refill tokens based on elapsed time
                if self.tokens < self.capacity:
                    elapsed = now - self.last_refill
                    refill = int(elapsed / self.refill_interval)
                    if refill > 0:
                        self.tokens = min(self.capacity, self.tokens + refill)
                        self.last_refill += refill * self.refill_interval

                if self.tokens > 0:
                    self.tokens -= 1
                    return

            # Not enough tokens, sleep briefly and retry
            time.sleep(0.05)


# ------------------------------ State Model --------------------------------

@dataclasses.dataclass
class ProcessedEntry:
    url: str
    asset_id: Optional[int]
    content_sha256: str
    display_name: str
    uploaded_at_unix: Optional[float]


class PersistentState:
    def __init__(self, state_path: Path) -> None:
        self.state_path = state_path
        self._entries: Dict[str, ProcessedEntry] = {}
        self.last_run_unix: Optional[float] = None
        self._load()

    def _load(self) -> None:
        if not self.state_path.exists():
            return
        try:
            data = json.loads(self.state_path.read_text(encoding="utf-8"))
        except Exception:
            return
        self.last_run_unix = data.get("last_run_unix")
        for url, entry in data.get("entries", {}).items():
            self._entries[url] = ProcessedEntry(
                url=url,
                asset_id=entry.get("asset_id"),
                content_sha256=entry.get("content_sha256", ""),
                display_name=entry.get("display_name", ""),
                uploaded_at_unix=entry.get("uploaded_at_unix"),
            )

    def save(self) -> None:
        payload = {
            "last_run_unix": time.time(),
            "entries": {
                url: dataclasses.asdict(entry) for url, entry in self._entries.items()
            },
        }
        ensure_dir(self.state_path.parent)
        self.state_path.write_text(json.dumps(payload, indent=2), encoding="utf-8")

    def get(self, url: str) -> Optional[ProcessedEntry]:
        return self._entries.get(url)

    def upsert(self, entry: ProcessedEntry) -> None:
        self._entries[entry.url] = entry


# ------------------------------ Roblox Client ------------------------------

class RobloxOpenCloudClient:
    def __init__(
        self,
        api_key: str,
        rate_limiter: TokenBucket,
        group_id: Optional[int] = None,
        session: Optional[requests.Session] = None,
    ) -> None:
        self.api_key = api_key
        self.group_id = group_id
        self.rate_limiter = rate_limiter
        self.session = session or requests.Session()
        self.session.headers.update({
            "x-api-key": self.api_key,
            "User-Agent": "FrigidRNG-Uploader/1.0 (+github)",
        })

    def _throttled_post(self, url: str, **kwargs) -> requests.Response:
        self.rate_limiter.acquire()
        return self.session.post(url, **kwargs)

    def _throttled_get(self, url: str, **kwargs) -> requests.Response:
        self.rate_limiter.acquire()
        return self.session.get(url, **kwargs)

    def upload_image(self, display_name: str, image_bytes: bytes, description: str = "") -> Tuple[Optional[int], Optional[str]]:
        request_obj = {
            "assetType": "Image",
            "displayName": display_name,
            "description": description,
        }
        if self.group_id is not None:
            request_obj["groupId"] = int(self.group_id)

        files = {
            "request": (None, json.dumps(request_obj), "application/json"),
            "fileContent": (f"{display_name}.png", image_bytes, "image/png"),
        }

        resp = self._throttled_post(ROBLOX_ASSETS_CREATE, files=files)
        if resp.status_code not in (200, 202):
            return None, f"Create asset failed: HTTP {resp.status_code} {resp.text[:300]}"
        try:
            body = resp.json()
        except Exception:
            return None, f"Create asset failed: invalid JSON response: {resp.text[:300]}"

        operation_id = (
            body.get("operationId")
            or body.get("id")
            or (body.get("path") or "").split("/")[-1]
        )
        if not operation_id:
            return None, f"Create asset failed: missing operation id in response: {body}"

        asset_id, err = self._poll_operation(operation_id)
        return asset_id, err

    def _poll_operation(self, operation_id: str) -> Tuple[Optional[int], Optional[str]]:
        # Exponential backoff polling to minimize requests
        delay_s = 1.5
        max_delay_s = 6.0
        deadline = time.time() + 90.0  # 90s timeout

        while time.time() < deadline:
            url = ROBLOX_ASSETS_OPERATION.format(operation_id=operation_id)
            resp = self._throttled_get(url)
            if resp.status_code != 200:
                return None, f"Operation poll failed: HTTP {resp.status_code} {resp.text[:300]}"
            try:
                body = resp.json()
            except Exception:
                return None, f"Operation poll failed: invalid JSON: {resp.text[:300]}"

            if body.get("done") is True:
                if "error" in body:
                    return None, f"Operation error: {body['error']}"
                response = body.get("response") or {}
                asset_id = response.get("assetId") or response.get("id")
                if asset_id is None:
                    return None, f"Operation done but missing assetId: {body}"
                try:
                    return int(asset_id), None
                except Exception:
                    return None, f"Operation returned non-integer assetId: {asset_id}"

            time.sleep(delay_s)
            delay_s = min(max_delay_s, delay_s * 1.5)

        return None, f"Operation {operation_id} timed out"


# ------------------------------ Downloads ----------------------------------

def download_png(url: str, timeout_s: float = 30.0, max_retries: int = 3) -> Tuple[Optional[bytes], Optional[str]]:
    for attempt in range(1, max_retries + 1):
        try:
            resp = requests.get(url, timeout=timeout_s)
            if resp.status_code == 200:
                content_type = resp.headers.get("content-type", "")
                if "image/png" not in content_type and not url.lower().endswith(".png"):
                    return None, f"Unexpected content-type: {content_type}"
                return resp.content, None
            elif 500 <= resp.status_code < 600:
                # Retry server errors
                pass
            else:
                return None, f"HTTP {resp.status_code} on download"
        except requests.RequestException as e:
            last_err = str(e)
            if attempt == max_retries:
                return None, last_err
        # Backoff
        time.sleep(0.5 * attempt)
    return None, "Unknown download error"


# ------------------------------ Main Logic ---------------------------------

def should_process(url: str, image_bytes: bytes, state: PersistentState) -> bool:
    sha = sha256_bytes(image_bytes)
    prior = state.get(url)
    if prior is None:
        return True
    if prior.content_sha256 != sha:
        # Content changed; reupload
        return True
    # Already processed same content
    return False


def process_url(
    url: str,
    client: RobloxOpenCloudClient,
    state: PersistentState,
    dry_run: bool,
) -> Tuple[str, Optional[int], Optional[str]]:
    image_bytes, err = download_png(url)
    if image_bytes is None:
        return url, None, f"download failed: {err}"

    display_name = extract_display_name_from_url(url)
    sha = sha256_bytes(image_bytes)

    if not should_process(url, image_bytes, state):
        entry = state.get(url)
        return url, entry.asset_id if entry else None, None

    if dry_run:
        return url, None, None

    asset_id, err = client.upload_image(
        display_name=display_name,
        image_bytes=image_bytes,
        description=f"Uploaded from {url}",
    )

    uploaded_at = time.time() if asset_id is not None else None
    state.upsert(
        ProcessedEntry(
            url=url,
            asset_id=asset_id,
            content_sha256=sha,
            display_name=display_name,
            uploaded_at_unix=uploaded_at,
        )
    )
    state.save()

    return url, asset_id, err


def main(argv: Optional[List[str]] = None) -> int:
    parser = argparse.ArgumentParser(description="Upload GitHub PNGs from skins.json to Roblox Open Cloud")
    parser.add_argument("--skins", default=str(Path("skins.json")), help="Path to skins.json")
    parser.add_argument("--state-dir", default=DEFAULT_STATE_DIR, help="Directory for persistent state JSON")
    parser.add_argument("--rpm", type=int, default=DEFAULT_RPM, help="Max requests per minute to Roblox (includes polls)")
    parser.add_argument("--group-id", type=int, default=None, help="Create assets under this Group ID (optional)")
    parser.add_argument("--max", dest="max_items", type=int, default=None, help="Process at most N URLs this run")
    parser.add_argument("--dry-run", action="store_true", help="Parse and download, but do not upload")
    parser.add_argument("--parallel-downloads", type=int, default=8, help="Concurrent GitHub downloads")
    parser.add_argument("--include-substring", action="append", default=None, help="Only include URLs containing this substring (can repeat)")
    parser.add_argument("--exclude-substring", action="append", default=None, help="Exclude URLs containing this substring (can repeat)")

    args = parser.parse_args(argv)

    if load_dotenv is not None:
        load_dotenv()

    api_key = os.getenv("ROBLOX_API_KEY")
    if not api_key and not args.dry_run:
        print("ERROR: ROBLOX_API_KEY not set (use .env or environment)", file=sys.stderr)
        return 2

    skins_path = Path(args.skins)
    if not skins_path.exists():
        print(f"ERROR: skins.json not found at {skins_path}", file=sys.stderr)
        return 2

    # State
    state_dir = Path(args.state_dir)
    ensure_dir(state_dir)
    state_path = state_dir / DEFAULT_STATE_FILE
    state = PersistentState(state_path)

    # Collect URLs
    urls = load_urls_from_skins_json(skins_path)

    # Filter include/exclude
    if args.include_substring:
        urls = [u for u in urls if any(s in u for s in args.include_substring)]
    if args.exclude_substring:
        urls = [u for u in urls if not any(s in u for s in args.exclude_substring)]

    if args.max_items:
        urls = urls[: args.max_items]

    if not urls:
        print("No matching GitHub raw PNG URLs found.")
        return 0

    # Warm-up: Prefetch downloads (optional concurrency)
    download_results: Dict[str, Tuple[Optional[bytes], Optional[str]]] = {}
    pending_urls = urls.copy()

    # Small thread pool for downloads to hide latency; uploads are sequentially rate-limited
    def _download_task(u: str) -> Tuple[str, Tuple[Optional[bytes], Optional[str]]]:
        return u, download_png(u)

    with concurrent.futures.ThreadPoolExecutor(max_workers=max(1, args.parallel_downloads)) as pool:
        for u, res in pool.map(_download_task, pending_urls):
            download_results[u] = res

    # Create client
    client = RobloxOpenCloudClient(
        api_key=api_key or "",
        rate_limiter=TokenBucket(args.rpm),
        group_id=args.group_id,
    )

    # Upload sequentially to better respect rate limits including polling
    success = 0
    skipped = 0
    failed = 0

    for url in urls:
        image_bytes, err = download_results.get(url, (None, "missing download"))
        if image_bytes is None:
            print(f"[skip] {url} -> download error: {err}")
            failed += 1
            continue

        display_name = extract_display_name_from_url(url)
        sha = sha256_bytes(image_bytes)
        prior = state.get(url)

        if prior is not None and prior.content_sha256 == sha and prior.asset_id:
            print(f"[skip] {display_name} already uploaded as asset {prior.asset_id}")
            skipped += 1
            continue

        if args.dry_run:
            print(f"[dry-run] would upload {display_name} from {url}")
            skipped += 1
            continue

        asset_id, err = client.upload_image(
            display_name=display_name,
            image_bytes=image_bytes,
            description=f"Uploaded from {url}",
        )

        uploaded_at = time.time() if asset_id is not None else None
        state.upsert(
            ProcessedEntry(
                url=url,
                asset_id=asset_id,
                content_sha256=sha,
                display_name=display_name,
                uploaded_at_unix=uploaded_at,
            )
        )
        state.save()

        if asset_id is not None:
            print(f"[ok] {display_name} -> asset {asset_id}")
            success += 1
        else:
            print(f"[err] {display_name} -> {err}")
            failed += 1

    print(f"Done. ok={success}, skipped={skipped}, failed={failed}")
    return 0 if failed == 0 else 1


if __name__ == "__main__":
    raise SystemExit(main())



