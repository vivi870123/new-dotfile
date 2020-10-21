local mappings = require 'mines/utils/mappings'

__LUA_FILETYPE_HOOKS = {
  dirvish = require 'mines/init/filetypes/dirvish',
  help = require "mines/init/filetypes/help",
  lua = require 'mines/init/filetypes/lua',
  magit = require 'mines/init/filetypes/magit',
  php = require 'mines/init/filetypes/php',
  startify = require 'mines/init/filetypes/startify',
}

local autocmds = {}

for filetype,fn in pairs(__LUA_FILETYPE_HOOKS) do
  autocmds['LuaFiletypeHooks_' .. mines.mappings.escape_keymap(filetype)] = {
    { 'FileType', filetype, ("lua __LUA_FILETYPE_HOOKS[%q]()"):format(filetype) }
  }
end

mappings.create_augroups(autocmds)
