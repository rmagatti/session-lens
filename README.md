<!-- Finish README -->
# Description
Session Lens extends [auto-session](https://github.com/rmagatti/auto-session) through Telescope.nvim, creating a simple session switcher with fuzzy finding capabilities.

<!-- TODO: use correct gif -->
<img src="https://github.com/rmagatti/readme-assets/blob/main/session-lens.gif" width="1000" />

# Usage
You can call the switcher from telescope
```viml
:Telescope session-lens search_session
```

Or straight from the plugin's path with lua
```viml
:lua require('telescope._extensions.session-lens.main').search_session()
```

# Installation
Any plugin manager should do, I use [Plug](https://github.com/junegunn/vim-plug).

`Plug 'rmagatti/session-lens'`

The plugin is lazy loaded when calling it for the first time but you can pre-load it with Telescope like this if you'd rather have autocomplete for it off the bat.
```lua
require("telescope").load_extension("session-lens")
```

# Configuration

### Custom
One can set the auto\_session root dir that will be used for auto session saving and restoring.
```lua
require('session-lens').setup {
    sorten_path=<true|false>,
}
```
:warning: WARNING :warning: If the directory does not exist, default directory will be used and an error message will be printed.

# Commands
Session Lens exposes one command
- `:SearchSession` triggers the customized session picker

# Compatibility
Neovim > 0.5

Tested with:
```
NVIM v0.5.0-dev+a1ec36f
Build type: Release
LuaJIT 2.1.0-beta3
```
