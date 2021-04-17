local has_telescope, telescope = pcall(require, "telescope")
local has_auto_session = pcall(require, "auto-session")
local SessionLens = require('telescope._extensions.session-lens.main')


if not has_telescope then
  error("This plugin requires telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)")
end

if not has_auto_session then
  error("This plugin requires auto-session (https://github.com/rmagatti/auto-session)")
end

return telescope.register_extension {
  setup = SessionLens.setup,
  exports = {
    search_session = SessionLens.search_session
  }
}
