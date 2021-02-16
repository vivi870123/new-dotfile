local parsers = require "nvim-treesitter.parsers"

local set_autocmd = mines.nvim.autocmds.set_autocmd

local custom_captures = {
  -- highlight own capture @foo.bar with highlight group "Identifier", see :h nvim-treesitter-query-extensions
  ['foo.bar'] = 'Identifier',
  ['function.call'] = 'LuaFunctionCall',
  ['function.bracket'] = 'Type',
}

local needed_parsers = {
  'bash', 'css', 'fennel', 'go', 'html', 'javascript', 'jsdoc',
  'json', 'lua', 'php', 'python', 'query', 'regex', 'ruby', 'rust',
  'swift', 'toml', 'tsx','typescript', 'yaml',
}

local set_folding = function()
  local parsers = require 'nvim-treesitter.parsers'
  local filetypes = {}
  for i, lang in ipairs(needed_parsers) do
    filetypes[i] = parsers.lang_to_ft(lang)
  end

  local foldexpr = 'nvim-treesitter#foldexpr()'

  filetypes =	vim.tbl_flatten(filetypes)
  for _, ft in pairs(filetypes) do
    if ft == vim.bo.filetype then
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = foldexpr
    end
  end
end


require('nvim-treesitter.configs').setup {
  indent = { enable=true },
  highlight = {
    -- false will disable the whole extension
    enable = true,
    disable = {'lua', 'typescript.tsx', 'typescript', 'tsx'},
    use_languagetree = false,
    custom_captures = custom_captures,
  },
  incremental_selection = {
    enable = true,
    disable = {},
    -- mappings for incremental selection (visual mappings)
    keymaps = {
      -- maps in normal mode to init the node/scope selection
      init_selection = '<M-w>',
      -- increment to the upper named parent
      node_incremental = '<M-w>',
      -- increment to the upper scope (as defined in locals.scm)
      scope_incremental = '<M-e>',
      -- decrement to the previous node
      node_decremental = '<M-C-w>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      disable = {},
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["ae"] = "@block.outer",
        ["ie"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["is"] = "@statement.inner",
        ["as"] = "@statement.outer",
        ["am"] = "@call.outer",
        ["im"] = "@call.inner",
        ["ad"] = "@comment.outer",
        ["id"] = "@comment.inner",
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        },
      }
    },
    swap = {
      enable = true,
      swap_next = { ["<M-a>"] = "@parameter.inner", },
    swap_previous = { ["<M-c-a>"] = "@parameter.inner" }},
  },
  ensure_installed = needed_parsers
}

set_folding()

local filetypes = {}

for lang,opts in pairs(parsers.list) do
  if parsers.has_parser(lang) then
    if opts.filetype ~= nil then
      lang = opts.filetype
    end
    filetypes[#filetypes + 1] = lang
    if opts.used_by ~= nil then
      vim.list_extend(filetypes, opts.used_by)
    end
  end
end

if #filetypes > 0 then
    set_autocmd{
        event   = 'FileType',
        pattern = filetypes,
        cmd     = 'setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()',
        -- cmd     = 'setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr() indentexpr=nvim_treesitter#indent()',
        group   = 'TreesitterAutocmds',
    }
end

return filetypes
