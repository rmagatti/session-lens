local Lib = require('telescope._extensions.session-lens.session-lens-library')
local AutoSession = require('auto-session')
local SessionLensActions = require("telescope._extensions.session-lens.session-lens-actions")

----------- Setup ----------
local SessionLens = {
  conf = {}
}

local defaultConf = {
  theme_conf = { winblend = 10, border = true, previewer =false },
  shorten_path = true
}

-- Set default config on plugin load
SessionLens.conf = defaultConf

function SessionLens.setup(config)
  SessionLens.conf = Lib.Config.normalize(config, SessionLens.conf)
end


local themes = require('telescope.themes')
local actions = require('telescope.actions')

SessionLens.search_session = function(custom_opts)
  local cwd = AutoSession.conf.auto_session_root_dir
  local shorten_path = custom_opts.shorten_path or SessionLens.conf.shorten_path
  local theme_opts = themes.get_dropdown(SessionLens.conf.theme_conf)
  local opts = {
    shorten_path = shorten_path,
    prompt_title = 'Sessions',
    entry_maker = Lib.make_entry.gen_from_file({cwd = cwd, shorten_path = shorten_path}),
    cwd = cwd,
    -- TOOD: support custom mappings?
    attach_mappings = function(_, map)
      actions.select_default:replace(SessionLensActions.source_session)
      map("i", "<c-d>", SessionLensActions.delete_session)
      return true
    end,
  }

  require("telescope.builtin").find_files(vim.tbl_deep_extend("force", opts, theme_opts, custom_opts or {}))
end

return SessionLens
