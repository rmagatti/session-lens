local path = require('plenary.path')
local AutoSession = require('auto-session')
local AutoSessionLib = require('auto-session.lib')

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
function Lib.make_entry.gen_from_file(opts)
  local root = AutoSession.get_root_dir()
  return function(line)
    return {
      ordinal = line,
      value = line,
      filename = line,
      cwd = root,
      display = function(_)
        local out = AutoSessionLib.unescape_dir(line):match("(.+)%.vim")
        if opts.path_display and vim.tbl_contains(opts.path_display, "shorten") then
          out = path:new(out):shorten()
        end
        if out then return out end
        return line
      end,
      path = path:new(root, line):absolute()
    }
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
