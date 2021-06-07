local AutoSession = require('auto-session')
local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')

local SessionLensActions = {}

SessionLensActions.source_session = function(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  AutoSession.AutoSaveSession()
  vim.cmd("%bd!")
  AutoSession.RestoreSession(selection.path)
end

-- TODO: make this refresh the picker and not close it instead
SessionLensActions.delete_session = function(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  AutoSession.DeleteSession(selection.path)
end

return SessionLensActions
