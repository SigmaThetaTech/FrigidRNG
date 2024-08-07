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
    PS C:\Users\username\Documents\GitHub\fashion-world> aftman install
    ```

2. ~~Run `wally install`~~ Lune will keep packages up-to-date for you!
3. Run `lune run init` in terminal to generate the project files. **You must do this every time you open the project for the first time.** This is spiritual replacement for running `rojo serve`.
  
      ```bash
      PS C:\Users\username\Documents\GitHub\fashion-world> lune run init
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
| `component` | Inserts a template for an [RBXUtil component](https://sleitnick.github.io/RbxUtil/api/Component/) with lifecycle methods. Note that this refers to an ECS component and not a UI component. Header already included. |
| `class` | Inserts a template for a typed class with a Janitor for garbage collection. Header is already included. |
| `fusioncomponent` | Inserts a template for a functional [Fusion](https://elttob.uk/Fusion/0.2/) component with typed props. Header already included. |

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
  3) Run `lune run init` in terminal to re-generate the output files
  6) Connect rojo again in Roblox Studio

### <u> Roblox UI Explorer </u>
The [Roblox UI explorer](https://marketplace.visualstudio.com/items?itemName=filiptibell.roblox-ui) is a much more intuitive way to navigate the project file structure versus the IDE explorer. It allows you to quickly, for instance, parent modules to other modules without needing to manually turn a module into a folder with a .init file. It also properly shows which service a module is parented to, which is useful for debugging. All of this uses Rojo's sourcemap.json, so it is always up to date with your files as long as you have run `lune run init`.

<a href="https://gyazo.com/00df5d80f1b581b2d83c26a2185be999"><img src="https://i.gyazo.com/00df5d80f1b581b2d83c26a2185be999.png" alt="Image from Gyazo" width="426"/></a>
