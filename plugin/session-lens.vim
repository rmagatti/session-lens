if exists('g:loaded_session_lens') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

let LuaSearchSession = luaeval('require("telescope._extensions.session-lens.main").search_session')

" Available commands
command! -nargs=0 SearchSession call LuaSearchSession()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_session_lens = 1
