local nvim = mines.nvim
local load_module = mines.helper.load_module

local set_autocmd = nvim.autocmds.set_autocmd

local compe = load_module "compe"
local lspkind = load_module "lspkind"

compe.setup {
  enabled = true;
  debug = false;
  min_length = 2;
  preselect = 'always';
  allow_prefix_unmatch = false;
  source = {
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    path = true;
    tags = true;
    snippets_nvim = true;
    vsnip = true;
  };
}

lspkind.init()

set_autocmd{
  event   = {'CursorHold', 'CursorHoldI'},
  pattern = "*",
  cmd     = [[lua require('nvim-lightbulb').update_lightbulb()]],
  group   = 'LightbulbPlugin',
}


return compe ~= nil
