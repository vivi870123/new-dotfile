local M = {}

function M.init(opts)
  opts = opts or {}
  local diagnostics = require "mines.plugins.lsp.diagnostics"

  diagnostics.lsp_diagnostic_sign(opts)
  -- handlers.overwrite_default()
  -- syntax.add_highlight()
end

return M
