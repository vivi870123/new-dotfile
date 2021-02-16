local nvim  = mines.nvim
local util = mines.util
local helper = mines.helper

local executable  = util.files.executable
local load_module = helper.load_module

local set_autocmd = nvim.autocmds.set_autocmd
local set_command = nvim.commands.set_command

local telescope = load_module('telescope')

if not telescope then
    return false
end

local should_reload = true
local reloader = function()
  if should_reload then
    RELOAD('plenary')
    RELOAD('popup')
    RELOAD('telescope')
  end
end

reloader()

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local themes  = require('telescope.themes')

telescope.setup {
  defaults = {
    vimgrep_arguments = util.tables.str_to_clean_tbl(helper.select_grep(false)),
    prompt_prefix = ' >',
    winblend = 0,
    preview_cutoff = 120,
    layout_strategy = 'horizontal',
    layout_defaults = {
      horizontal = {
        width_padding = 0.1,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      }
    },
    scroll_strategy = 'cycle',
    selection_strategy = 'reset',
    sorting_strategy = "ascending",
    prompt_position = "top",
    color_devicons = true,

    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<ESC>"] = actions.close,
        ["<C-s>"] = actions.goto_file_selection_split,
        ["<TAB>"] = actions.add_selection,
        ["<C-q>"] = actions.send_to_qflist,
      },
      n = { ["<ESC>"] = actions.close }
    },

    borderchars = {
      { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
      preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    },
    set_env = { ['COLORTERM'] = 'truecolor' },
    file_sorter = sorters.get_fzy_sorter,
    generic_sorter =  sorters.get_fzy_sorter,
    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
  },

  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },

    fzf_writer = {
      use_highlighter = false,
      minimum_grep_characters = 4,
    }
  },
}

-- Load the fzy native extension at the start.
telescope.load_extension("gh")
telescope.load_extension("fzy_native")


local M = {}

function M.show_diagnostics(opts)
  opts = opts or {}

  vim.lsp.diagnostic.set_loclist({open_loclist = false})

  require'telescope.builtin'.loclist(opts)
end

function M.find_files()
  -- command for find file
  local ignore_globs = {
    ".git", ".ropeproject", "__pycache__", ".venv", "venv",
    "node_modules", "vendor", "images", "*.min.*", "img", "fonts"
  }

  local cmd = nil;
  if vim.fn.executable("rg") then
    cmd = {"rg", "--follow", "--hidden", "--files"}
    for _, x in ipairs(ignore_globs) do
      table.insert(cmd, "--glob=!" .. x)
    end
  elseif vim.fn.executable("fd") then
    cmd = {"fd", ".", "--hidden", "--type", "f"}
    for _, x in ipairs(ignore_globs) do
      table.insert(cmd, "--exclude")
      table.insert(cmd, x)
    end
  end

  require('telescope.builtin').find_files{ find_command = cmd }
end

function M.edit_zsh()
  local ignore_globs = { "*.zwc", }

  local cmd = nil;
  if vim.fn.executable("rg") then
    cmd = {
      "rg", "--follow", "--hidden", "--files"
    }
    for _, x in ipairs(ignore_globs) do
      table.insert(cmd, "--glob=!" .. x)
    end
  end

  require('telescope.builtin').find_files {
    find_command = cmd,
    shorten_path = false,
    cwd = "~/.config/zsh/",

    layout_strategy = 'horizontal',
    layout_config = { preview_width = 0.55, },
  }
end

function M.edit_neovim()
  require('telescope.builtin').find_files {
    shorten_path = false,
    cwd = "~/.config/nvim/",

    layout_strategy = 'horizontal',
    layout_config = {
      preview_width = 0.55,
    },
  }
end

function M.git_files()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  require('telescope.builtin').git_files(opts)
end

function M.commands()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  require('telescope.builtin').commands(opts)
end

function M.lsp_code_actions()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  require('telescope.builtin').lsp_code_actions(opts)
end

function M.live_grep()
  require('telescope').extensions.fzf_writer.staged_grep {
    shorten_path = true,
    previewer = false,
    fzf_separator = "|>",
  }
end

function M.grep_prompt()
  require('telescope.builtin').grep_string {
    shorten_path = true,
    search = vim.fn.input("Grep String > "),
  }
end

function M.oldfiles()
  require('telescope.builtin').oldfiles { layout_strategy = 'vertical' }
end

function M.installed_plugins()
  require('telescope.builtin').find_files {
    cwd = vim.fn.stdpath('data') .. '/site/pack/packer/start/'
  }
end


function M.buffers()
  require('telescope.builtin').buffers {
    shorten_path = false,
  }
end

function M.curbuf()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,

    -- layout_strategy = 'current_buffer',
  }
  require('telescope.builtin').current_buffer_fuzzy_find(opts)
end

function M.help_tags()
  require('telescope.builtin').help_tags {
    show_version = true,
  }
end

function M.search_all_files()
  require('telescope.builtin').find_files {
    find_command = { 'rg', '--no-ignore', '--files', },
  }
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end
})
