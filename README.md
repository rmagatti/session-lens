<!-- Finish README -->
# Session Lens
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
:lua require('session-lens').search_session()
```

# Installation
Any plugin manager should do.

Plug
```viml
" Plugin dependencies
Plug 'nvim-telescope/telescope.nvim'
Plug 'rmagatti/auto-session'

Plug 'rmagatti/session-lens'
```
See https://github.com/nvim-telescope/telescope.nvim for it's dependencies

Packer
```lua
use {
  'rmagatti/session-lens',
  requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
  config = function()
    require('session-lens').setup({--[[your custom config--]]})
  end
}
```

The plugin is lazy loaded when calling it for the first time but you can pre-load it with Telescope like this if you'd rather have autocomplete for it off the bat.
```lua
require("telescope").load_extension("session-lens")
```

# Configuration

### Custom
Options can be set by calling the setup function, a common option is changing the shorten path behaviour.
```lua
require('session-lens').setup {
    path_display={'shorten'},
}
```

Another example would be changing how the dropdown looks, this can be done by setting the `theme_conf` in the setup opts.
The options in `theme_conf` get passed into `require('telescope.themes').get_dropdown(theme_conf)`, so anything supported by `get_dropdown` can be used here as well.
```lua
require('session-lens').setup {
  path_display = {'shorten'},
  theme_conf = { border = false },
  previewer = true
}
```
👇
<img width="1000" alt="Screen Shot 2021-04-17 at 9 17 43 PM" src="https://user-images.githubusercontent.com/2881382/115133046-5eed1680-9fc2-11eb-9bda-dd80d649e761.png">

In addition to the above configs, since everything gets passed into `telescope.builtin.find_files`, any configs passed to the `setup` if supported by `find_files` will override the default behaviour, for example:
```lua
require('session-lens').setup {
    prompt_title = 'YEAH SESSIONS',
}
```
👇
<img width="1000" alt="Screen Shot 2021-04-17 at 8 16 49 PM" src="https://user-images.githubusercontent.com/2881382/115132025-d9fdff00-9fb9-11eb-8549-22a7131a3d59.png">


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
