local M = {}

function M.setup()
  vim.g.indentLine_enabled= 1
  vim.g.indentLine_faster	= 1
  vim.g.indentline_char	= '┆'
  vim.g.indentLine_concealcursor = 'niv'
  vim.g.indentLine_color_term = 239
  vim.g.indentLine_color_gui = '#556874'
  vim.g.indentLine_setConceal = 0
  vim.g.indentLine_showFirstIndentLevel = 1
  vim.g.indentLine_setColors = 1
  vim.g.indentLine_bufNameExclude = {
    '_.*',
    'vista',
    'vista_kind',
    'startify',
    'fzf'
  }
  vim.g.indentLine_bufTypeExclude = {
    'help',
    'terminal',
    'startify',
    'fzf'
  }
  vim.g.indentLine_filetypeExclude = {
    'terminal',
    'dbui',
    'startify',
    'terminal',
    'json',
    'jsonc',
    'vista',
    'vista_kind',
    'help',
    'tagbar',
    'vimfiler',
    'markdown',
    'dashboard',
    'vimwiki',
    'man',
    'vista_markdown'
  }

end

return M
