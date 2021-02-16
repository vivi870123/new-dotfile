local M = {}

function M.setup()
  vim.g.delimitMate_expand_cr = 0
  vim.g.delimitMate_expand_space = 1
  vim.g.delimitMate_smart_quotes = 1
  vim.g.delimitMate_expand_inside_quotes = 0
  vim.g.delimitMate_excluded_ft = 'mail,txt'

  -- augroup user_plugin_delimitMate
  --   au!
  --   au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
  --   au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  --   au FileType tex let b:delimitMate_quotes = ""
  --   au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  -- augroup END
end

return M
