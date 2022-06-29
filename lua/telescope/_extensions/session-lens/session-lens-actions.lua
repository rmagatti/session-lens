local AutoSession = require('auto-session')
local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')

local SessionLensActions = {}

SessionLensActions.source_session = function(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  vim.defer_fn(function ()
    AutoSession.AutoSaveSession()
    vim.cmd("%bd!")
    AutoSession.RestoreSession(selection.path)
  end, 50)
end

SessionLensActions.delete_session = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  current_picker:delete_selection(function(selection)
    AutoSession.DeleteSession(selection.path)
  end)
end


return SessionLensActions
