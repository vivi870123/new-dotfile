local M = {}

function M.setup()
  vim.g.doge_doc_standard_c      = "doxygen_qt"
  vim.g.doge_doc_standard_cpp    = "doxygen_qt"
  vim.g.doge_doc_standard_python = "numpy"
  vim.g.doge_enable_mappings = false
  vim.g.doge_mapping_comment_jump_forward = '<c-j>'
  vim.g.doge_mapping_comment_jump_backward = '<c-k>'
end

return M
