local path = require('telescope.path')
local utils = require('telescope.utils')

local Config = {}
local Lib = {
  make_entry = {},
  logger = {},
  conf = {
    logLevel = false
  },
  Config = Config,
  _VIM_FALSE = 0,
  _VIM_TRUE  = 1,
  ROOT_DIR = "~/.config/nvim/sessions/"
}



-- Setup ======================================================
function Lib.setup(config)
  Lib.conf = Config.normalize(config)
end

function Config.normalize(config, existing)
  local conf = existing
  if Lib.isEmptyTable(config) then
    return conf
  end

  for k, v in pairs(config) do
    conf[k] = v
  end

  return conf
end
-- ====================================================

-- Helper functions ===============================================================
local function hasValue (tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end


function Lib.isEmptyTable(t)
  if t == nil then return true end
  return next(t) == nil
end

function Lib.isEmpty(s)
  return s == nil or s == ''
end

function Lib.endsWith(str, ending)
  return ending == "" or str:sub(-#ending) == ending
end

function Lib.appendSlash(str)
  if not Lib.isEmpty(str) then
    if not Lib.endsWith(str, "/") then
      str = str.."/"
    end
  end
  return str
end
-- ===================================================================================


-- ==================== SessionLens ==========================
do
  local lookup_keys = {
    ordinal = 1,
    value = 1,
    filename = 1,
    cwd = 2,
  }

  function Lib.make_entry.gen_from_file(opts)
    opts = opts or {}

    local cwd = vim.fn.expand(opts.cwd or vim.fn.getcwd())

    local path_display = opts.path_display

    local mt_file_entry = {}

    mt_file_entry.cwd = cwd
    mt_file_entry.display = function(entry)
      -- Revert session files back to paths for easier reading
      -- This affects the display only, a selection still uses the correct file name.
      local is_win32 = vim.fn.has('win32') == Lib._VIM_TRUE
      local entry_value = entry.value:gsub("%%", "/")
      local display = is_win32 and path.make_relative(entry_value:gsub("%++", ":"), cwd) or path.make_relative(entry_value, cwd)

      -- there problem with telescope path_shorten() for windows
      -- see https://github.com/nvim-telescope/telescope.nvim/issues/706
      if vim.tbl_contains(path_display, "shorten") and not is_win32 then
        display = utils.path_shorten(display)
      end

      -- Strip file extensions since sessions always have the same .vim extension.
      local filename_only = display:match("(.+)%..+")

      return filename_only
    end

    -- No idea what this block does, got it from the telescope code, may or may not figure it out later.
    mt_file_entry.__index = function(t, k)
      local raw = rawget(mt_file_entry, k)
      if raw then return raw end

      if k == "path" then
        local retpath = t.cwd .. path.separator .. t.value
        if not vim.loop.fs_access(retpath, "R", nil) then
          retpath = t.value
        end
        return retpath
      end

      return rawget(t, rawget(lookup_keys, k))
    end

    return function(line)
      return setmetatable({line}, mt_file_entry)
    end
  end
end
-- ===================================================================================

-- Logger =========================================================
function Lib.logger.debug(...)
  if Lib.conf.logLevel == 'debug' then
    print(...)
  end
end

function Lib.logger.info(...)
  local valid_values = {'info', 'debug'}
  if hasValue(valid_values, Lib.conf.logLevel) then
    print(...)
  end
end

function Lib.logger.error(...)
   error(...)
end
-- =========================================================


return Lib
