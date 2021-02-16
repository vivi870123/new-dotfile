local M = {}

function M.setup()
  vim.g.vim_markdown_frontmatter = 1
  vim.g.vim_markdown_strikethrough = 1
  vim.g.vim_markdown_folding_disabled = 1
  vim.g.vim_markdown_conceal = 1
  vim.g.vim_markdown_conceal_code_blocks = 1
  vim.g.vim_markdown_new_list_item_indent = 0
  vim.g.vim_markdown_toc_autofit = 0
  vim.g.vim_markdown_edit_url_in = 'vsplit'
  vim.g.vim_markdown_fenced_languages = {
    ['c++']  = 'cpp',
    viml     = 'vim',
    bash     = 'sh',
    ini      = 'dosini',
    js       = 'javascript',
    json     = 'javascript',
    jsx      = 'javascriptreact',
    tsx      = 'typescriptreact',
    docker   = 'Dockerfile',
    makefile = 'make',
    py       = 'python'
  }
end

return M
