local vim,lsp = vim,vim.lsp


-- Add I custom handlers function in lsp server config
return function()

  lsp.handlers["textDocument/codeAction"] = function()
    local ok, _ = pcall(require, 'mines.plugins.telescope')
    if ok then
      require'telescope.builtin'.lsp_code_actions{}
    else
      lsp.buf.lsp_code_actions()
    end
  end

  lsp.handlers["textDocument/documentSymbol"] = function()
    local ok, _ = pcall(require, 'plugins.telescope')
    if ok then
      require'telescope.builtin'.lsp_document_symbols{}
    else
      lsp.buf.document_symbol()
    end
  end

  lsp.handlers["workspace/symbol"] = function()
    local ok, _ = pcall(require, 'plugins.telescope')
    if ok then
      require'telescope.builtin'.lsp_workspace_symbols{}
    else
      lsp.buf.workspace_symbol()
    end
  end

  lsp.handlers["textDocument/references"] = function()
    local ok, _ = pcall(require, 'plugins.telescope' )
    if ok then
      require'telescope.builtin'.lsp_references{}
    else
      lsp.buf.references()
    end
  end

  lsp.handlers['textDocument/hover'] = function(_, method, result)
    lsp.util.focusable_float(method, function()
      if not (result and result.contents) then return end
      local markdown_lines = lsp.util.convert_input_to_markdown_lines(result.contents)
      markdown_lines = lsp.util.trim_empty_lines(markdown_lines)
      if vim.tbl_isempty(markdown_lines) then return end

      local bufnr,contents_winid,_,border_winid = window.fancy_floating_markdown(markdown_lines)
      lsp.util.close_preview_autocmd({"CursorMoved", "BufHidden", "InsertCharPre"}, contents_winid)
      lsp.util.close_preview_autocmd({"CursorMoved", "BufHidden", "InsertCharPre"}, border_winid)
      return bufnr,contents_winid
    end)
  end

  -- diagnostic callback
  lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(
    lsp.diagnostic.on_publish_diagnostics, {
      -- Enable underline, use default values
      underline = true,
      -- Enable virtual text, override spacing to 4
      virtual_text = false,
      signs = {
        enable = true,
        priority = 20
      },
      -- Disable a feature
      update_in_insert = false,
    })

  lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
      return
    end
    if not vim.bo[bufnr].modified then
      local view = vim.fn.winsaveview()
      lsp.util.apply_text_edits(result, bufnr)
      vim.fn.winrestview(view)
      if bufnr == vim.api.nvim_get_current_buf() then
        vim.cmd("noautocmd :update")
      end
    end
  end
end

