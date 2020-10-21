local vim = vim

return function()
  vim.api.nvim_command [[:setlocal signcolumn=no]]
  vim.api.nvim_command [[IndentLinesDisable]]
end
