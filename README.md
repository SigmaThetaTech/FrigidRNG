<p align="center">
  <img src="https://i.gyazo.com/ff9bcc92cc7f9360c93a056e43231e56.jpg" alt="Logo">
</p>


  <h1 style="text-align: center; margin: 0; color: white; letter-spacing: -1px; font-family: 'Copy Of Topoltrial', sans-serif; font-size: 40px; font-weight: 800; line-height: 1;">ΣTΞCH</h1>
  <h3 style="text-align: center; margin: 0; color: white; letter-spacing: -1px; font-family: 'Copy Of Topoltrial', sans-serif; font-size: 20px; font-weight: 800; line-height: 1;">Project base</h3>


# Extensions Setup
Recommended extensions are included in the `.vscode/extensions.json` file.
<br>To install them, open the extensions sidebar in VSCode and search for `@recommended` to find the list of recommended extensions.
<br>Here are the recommended extensions:
- [Luau Language Server by JohnnyMorganz](https://marketplace.visualstudio.com/items?itemName=JohnnyMorganz.luau-lsp) for best intellisense support.
- [Roblox UI by Filip Tibell](https://marketplace.visualstudio.com/items?itemName=filiptibell.roblox-ui) for an explorer view that resembles the Roblox explorer.
- [Roblox API Search by evaera](https://marketplace.visualstudio.com/items?itemName=evaera.roblox-api-explorer) for offline access to the Roblox API documentation using Ctrl+Shift+P and typing `Roblox API`.


# Toolchain Setup
### Install Aftman for your system:
1. [Download the latest release of Aftman](https://github.com/LPGhatguy/aftman/releases) for your platform.<br>
Alternatively, you may use a package manager to download & install aftman:
   ### Using [Cargo](https://rustup.rs/) 
   `cargo install aftman`
   ### OR [Homebrew](https://brew.sh/)
   `brew install aftman`
   <br></br>

2. With Aftman installed, navigate to the root directory of this repository and run `aftman install` to install the required CLI tools according to the `aftman.toml` file in the project root.
    ```bash
    PS C:\Users\username\Documents\GitHub\repo_name> aftman install
    ```

2. ~~Run `wally install`~~ Lune will keep packages up-to-date for you!
3. Run `lune run init` in terminal to generate the project files. **You must do this every time you open the project for the first time.** This is spiritual replacement for running `rojo serve`.
  
      ```bash
      PS C:\Users\username\Documents\GitHub\repo_name> lune run init
      ```
<br>

# Initialization (Rinse and repeat!)
👉 <u>**You must run</u> `lune run init` <u>every time you open the project for the first time.**</u> 👈
<br><br>This will run several necessary background processes to fully utilize Luau features and intellisense.
<br>It will also serve rojo and sync package versions for you. 
<br>

**DO NOT** use `rojo serve`, as it will not run necessary background processes.
<br>
**DO NOT** use the VSCode extension for rojo as it uses an outdated, '22 version of Rojo that does not support newer sourcemap features.

# 🧶 Interlace Framework
This repository's "framework" is a modern derivative of Knit, affectionately called "Interlace". Interlace uses type-annotated remotes, works with intellisense, and functions nearly identical to Knit:

### 🧵 <u>Lifecycle Methods</u>
Interlace follows a similar execution model as Knit. First, the network is set up and remotes are created. Then, the `:InterlaceInit()` method is called sequentially. After that, all modules descendants of `./src/Client` and `./src/Server` that *aren't* services or controllers are required. Finally, the `:InterlaceStart()` method is called on all services and controllers.

| Interlace Lifecycle Method | Knit Equivalent | Description |
|-|-|-|
| `:InterlaceInit()` | `:KnitInit()` | Called first. Remotes are guaranteed to be present at this stage. |
| `:InterlaceStart()` | `:KnitStart()` | Called after :InterlaceInit(). Execute game instructions here. |

### ⚡ <u>Interlace Remotes</u>
Interlace utilizes a centralized, type-annotated network module written in Luau to handle the creation of RemoteEvents and RemoteFunctions ahead of Interlace initialization. This means that remotes are guaranteed to be present before `:InterlaceInit()` and `:InterlaceStart()` are called. Requiring the Network module is simple:
```lua
local Network = require("@Network")
```
Treat the network module as a dictionary of RemoteEvents and RemoteFunctions instances. Intellisense will show you available remotes as well as their parameters and return types. To create a remote, head to the `Network.luau` file under Shared and use the `remotefunction` or `remoteevent` snippets to create a new typed remote:

```lua
-- Network.luau
-- ...
return {
  RemoteFunctionName = RemoteFunction("RemoteFunctionName") :: RF<(argumentTypes), (returnTypes)>,
  RemoteEventName = RemoteEvent("RemoteEventName") :: RE<(argumentTypes)>,
}
```

Refer to Roblox's [RemoteFunction](https://create.roblox.com/docs/reference/engine/classes/RemoteFunction) and [RemoteEvent](https://create.roblox.com/docs/reference/engine/classes/RemoteEvent) API documentation just like you would with any normal RemoteFunction or RemoteEvent. The only difference is that you can now see the types of the arguments and return values in your IDE. This was the goal with Interlace: The freedom of good ol' RemoteEvents and RemoteFunctions, but with the power of type annotations.
<br />

# Snippets
VS Code snippets are provided to serve as a template for commonly used code patterns specific to this codebase. They help with visual organization and speed up the development process by writing boilerplate code for you. Snippets are located in the `.vscode/project_snippets.code-snippets` file. 

**Instructions**
1) Choose a snippet prefix from the list below and type it in any file.
2) An intellisense prompt will appear. Press [Tab] to insert the snippet.
3) Some snippets have tabstops. Traverse through tabstops with [Tab] and start typing to fill in fields.

### Essential Snippets
| Prefix | Purpose |
|-|-|
| `header`| Inserts a standardized header for every gameplay file |
| `service`| Inserts a template for a sever-side "service" ModuleScript with :Init() and :Start() lifecycle methods. Use after `header`. |
| `controller` | Inserts a template for a client-side "controller" ModuleScript with :Init() and :Start() lifecycle methods. Use after `header`. |
| `method` | Inserts a template for a method with Moonwave-ready documentation. Traverse placeholders with [Tab] to enter apropriate fields. |
| `remotefunction` | Use inside `Network.luau` to create a RemoteFunction with types. |
| `remoteevent` | Use inside `Network.luau` to create a RemoteEvent with types. |
| `component` | Complete file template for an [RBXUtil component](https://sleitnick.github.io/RbxUtil/api/Component/) with lifecycle methods. Note that this refers to an ECS component and not a UI component. Header already included. |
| `class` | Complete file template for a typed class with a Janitor for garbage collection. Header is already included. |
| `fusioncomponent` | Complete file template for a functional [Fusion](https://elttob.uk/Fusion/0.3/) component with typed props. Header already included. |

### Other Snippets
| Prefix | Purpose |
|-|-|
| `setter` | Inserts a template for a documented setter method. |
| `getter` | Inserts a template for a documented getter method. |
| `sectionheader` | Inserts a section header for organizing code. |
<br>

# Important Notes:

### <u> Renaming Files and Folders </u>
  When renaming a folder or file in the src, please follow the following steps to prevent bugs due to duplicate files:
  1) Stop rojo and darklua by pressing `Ctrl + C` or `Cmd + c` in the terminal you ran `lune run init` in
  2) Rename the folder or file
  3) Delete rojo output folders in Roblox Studio: `RojoClient`, `RojoServer`, `RojoShared`
  4) Run `lune run init` in terminal to re-generate the output files
  5) Connect rojo again in Roblox Studio

### <u> Roblox UI Explorer </u>
The [Roblox UI explorer](https://marketplace.visualstudio.com/items?itemName=filiptibell.roblox-ui) is a much more intuitive way to navigate the project file structure versus the IDE explorer. It allows you to quickly, for instance, parent modules to other modules without needing to manually turn a module into a folder with a .init file. It also properly shows which service a module is parented to, which is useful for debugging. All of this uses Rojo's sourcemap.json, so it is always up to date with your files as long as you have run `lune run init`.

## Skins image uploader (GitHub -> Roblox Open Cloud)

This repository includes a small Python utility that parses `skins.json`, locates `raw.githubusercontent.com` PNG URLs, downloads them, and uploads each image to Roblox Open Cloud as an Image asset. It safely rate-limits requests and persists state to only process new/changed images on subsequent runs.

Reference: [Roblox Open Cloud: POST /v1/assets](https://create.roblox.com/docs/reference/cloud/assets/v1#POST-v1-assets)

### Setup
1. Install Python 3.10+.
2. Install dependencies:
   ```powershell
   pip install -r requirements.txt
   ```
3. Set your Open Cloud API key (must have Assets.Write scope). Example for PowerShell:
   ```powershell
   $env:ROBLOX_API_KEY = "rbx_oauth_xxx_your_token_here"
   ```
   Optionally, create a `.env` file next to the repo root with `ROBLOX_API_KEY=...`.

### Run examples
- Dry-run to preview which images would be uploaded:
  ```powershell
  python scripts\upload_skins_images.py --dry-run --max 10
  ```
- Upload under a Group creator (replace the ID):
  ```powershell
  python scripts\upload_skins_images.py --group-id 1234567 --rpm 50
  ```
- Only include images whose URL contains a substring (can repeat):
  ```powershell
  python scripts\upload_skins_images.py --include-substring weapon_cases --include-substring base_weapons
  ```

Notes:
- State is saved at `.state/skins_image_uploads.json` and used to skip previously uploaded content unless the source image changes.
- The tool defaults to 50 requests/minute and counts polls; adjust `--rpm` below your total account limit (60 rpm across all keys).
- Windows Task Scheduler can be used to run this periodically. Example action: `python` with arguments `scripts\upload_skins_images.py --group-id 1234567 --rpm 50` and Start in set to the repo root.
