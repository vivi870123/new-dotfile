RELOAD = require('plenary.reload').reload_module

R = function(name)
  RELOAD(name)
  return require(name)
end

P = function(v)
  print(vim.inspect(v))
  return v
end

--[ Main functions ]--
local initial_mappings = function()
  -- disable ex mode
  vim.fn.nvim_set_keymap('n', 'Q',  '', {})
  vim.fn.nvim_set_keymap('n', 's',  '', {})
  vim.fn.nvim_set_keymap('n', ',',  '', {})
  vim.fn.nvim_set_keymap('x', ',',  '', {})
  vim.fn.nvim_set_keymap('n', ';',  '', {})
  vim.fn.nvim_set_keymap('x', ';',  '', {})
  vim.fn.nvim_set_keymap('x', ';;', '', {})
  vim.fn.nvim_set_keymap('n', ' ',  '', {noremap = true})
  vim.fn.nvim_set_keymap('x', ' ',  '', {noremap = true})
  vim.g.mapleader = " "
  vim.g.maplocalleader = ";"
end

--[ Nvim core settings ]--
require "mines"

initial_mappings()
require "mines.settings"

--[ Theme ]--
require "mines.plugins.galaxyline"

--[ Plugins ]--
require "mines.plugins"
