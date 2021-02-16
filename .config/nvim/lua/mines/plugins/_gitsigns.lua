local M = {}

function M.setup()
  require('gitsigns').setup {
    signs = {
      add = {
        hl = 'GitsignsAdd',
        text = '▎',
        numhl = 'GitSignsAddNr'
      },

    change = {
      hl = 'GitsignsChange',
      text = '▎',
      numhl = 'GitSignsChangeNr'
    },
    delete = {
      hl = 'GitsignsDelete',
      text = '▘',
      show_count = true,
      numhl = 'GitSignsDeleteNr'
    },
    topdelete = {
      hl = 'GitsignsDelete',
      text = '▍',
      show_count = true,
      numhl = 'GitSignsDeleteNr'
    },
    changedelete = {
      hl = 'GitsignsChangeDelete',
      text = '▍',
      show_count = true,
      numhl = 'GitSignsChangeNr'
    }
  },
  count_chars = {
    [1] = '',
    [2] = '₂',
    [3] = '₃',
    [4] = '₄',
    [5] = '₅',
    [6] = '₆',
    [7] = '₇',
    [8] = '₈',
    [9] = '₉',
    ['+'] = '₊'
  },
  numhl = false,

  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ['n ]g'] = {
      expr = true,
      "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"
    },
    ['n [g'] = {
      expr = true,
      "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"
    },

    ['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>gp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line()<CR>'
  },

  watch_index = { interval = 1000 },
  sign_priority = 6,
  status_formatter = nil -- Use default
}

end

return M
