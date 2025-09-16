# Copilot Instructions for ΣTΞCH (GET-HIT-BY-A-BUS)

## Project Architecture & Patterns
- **Framework:** Uses a custom "Interlace" framework (see `README.md`) inspired by Knit, with lifecycle methods `:InterlaceInit()` and `:InterlaceStart()` for both client and server modules.
- **Directory Structure:**
  - `src/Client` and `src/Server`: Main entry points for client and server logic. Modules here are auto-required by the framework.
  - `src/Shared`: Shared code, including the critical `Network.luau` for typed RemoteEvents/RemoteFunctions.
  - `Packages/` and `ServerPackages/`: External dependencies managed by Lune and Aftman.
- **Remotes:** All cross-boundary communication uses the centralized, type-annotated `Network.luau` module. Add new remotes here using the `remotefunction` or `remoteevent` snippets.
- **Snippets:** Use VS Code snippets in `.vscode/project_snippets.code-snippets` for common patterns (e.g., `service`, `controller`, `component`, `class`).

## Developer Workflows
- **Initialization:** Run `lune run init` in the project root every time you open the project for the first time. This sets up background processes, synchronizes packages, and serves Rojo.
- **Do NOT** use `rojo serve` or the Rojo VSCode extension; only use `lune run init` for serving and syncing.
- **Renaming Files/Folders:**
  1. Stop all background processes (`Ctrl+C` in terminal)
  2. Rename as needed
  3. Delete Rojo output folders in Roblox Studio (`RojoClient`, `RojoServer`, `RojoShared`)
  4. Run `lune run init` again

## Conventions & Special Rules
- **No Automated Tests:** Testing is done in Roblox Studio, not in the IDE. Do not write or expect automated tests in this repo.
- **Luau LSP:** Linter/type errors from Luau LSP are sometimes unreliable. Use type annotations as per https://luau.org/typecheck, but don't retry endlessly to satisfy the LSP.
- **Type Annotations:** Prefer explicit types for remotes and module interfaces. Avoid `any` unless required.
- **Component Pattern:** Use the `component` snippet for ECS-style components (see [RBXUtil Component](https://sleitnick.github.io/RbxUtil/api/Component/)).

## Integration & Dependencies
- **Aftman** manages CLI tools (see `aftman.toml`).
- **Lune** manages package installation and project setup (see `wally.toml`, `lune/`).
- **Fusion** and other libraries are in `Packages/`.

## Key Files
- `README.md`: Full setup, workflow, and framework details
- `src/Shared/Network.luau`: Central remote definitions
- `.vscode/project_snippets.code-snippets`: Snippet templates for all major patterns

---
**When in doubt, consult the `README.md` for up-to-date workflow and architecture guidance.**
