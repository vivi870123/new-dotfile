local M = {}


function M.setup()
  vim.g['vista#renderer#enable_icon'] = 1
  vim.g.vista_floating_delay = 1000
  vim.g.vista_default_executive = 'ctags'
  vim.g.vista_close_on_jump = 1
  vim.g.vista_disable_statusline = vim.fn.exists('g:loaded_lightline')
  vim.g.vista_echo_cursor_strategy = 'floating_win'
  vim.g.vista_fzf_preview = { 'right:50%'}
  vim.g.vista_icon_indent = {" ", " "}
  vim.g.vista_sidebar_width = 30
  vim.g.vista_vimwiki_executive = 'markdown'
  vim.g.vista_executive_for = {
    c               = 'nvim_lsp',
    cpp             =	'nvim_lsp',
    css             =	'nvim_lsp',
    html            = 'nvim_lsp',
    js              =	'nvim_lsp',
    json            = 'nvim_lsp',
    jsx             =	'nvim_lsp',
    julia           = 'nvim_lsp',
    latex           = 'nvim_lsp',
    less            = 'nvim_lsp',
    lua             =	'nvim_lsp',
    ocaml           = 'nvim_lsp',
    pandoc          = 'markdown',
    python          = 'nvim_lsp',
    rust            = 'nvim_lsp',
    sass            = 'nvim_lsp',
    scss            = 'nvim_lsp',
    sh              =	'nvim_lsp',
    tex             =	'nvim_lsp',
    vim             = 'nvim_lsp',
    vimwiki         = 'markdown',
    wiki            = 'markdown',
    javascript      = 'nvim_lsp',
    typescript      = 'nvim_lsp',
    typescriptreact = 'nvim_lsp',
    javascriptreact = 'nvim_lsp',
  }
end

return M
