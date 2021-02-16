local M = {}

function M.lsp_diagnostic_sign(opts)
  opts = opts or {}
  local group = {
    err_group = {
      highlight = 'LspDiagnosticsSignError',
      sign = opts.error_sign or ''
    },
    warn_group = {
      highlight = 'LspDiagnosticsSignWarning',
      sign = opts.warn_sign or ''
    },
    hint_group = {
      highlight = 'LspDiagnosticsSignHint',
      sign = opts.hint_sign or ''
    },
    infor_group = {
      highlight = 'LspDiagnosticsSignInformation',
      sign = opts.infor_sign or ''
    },
  }

  for _,g in pairs(group) do
    vim.fn.sign_define(
      g.highlight, {
        text   = g.sign,
        texthl = g.highlight,
        linehl = '',
        numhl  = '',
      })
  end
end

return M
