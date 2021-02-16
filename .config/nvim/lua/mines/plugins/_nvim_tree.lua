local M = {}

function M.setup()
  vim.g.nvim_tree_hide_dotfiles = 1
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_bindings = {
    edit            = {'<CR>', 'l'},
    edit_vsplit     = 'sg',
    edit_split      = 'sv',
    edit_tab        = 'st',
    create          = 'K',
    remove          = 'dd',
    copy            = 'c',
    toggle_dotfiles = '.',
  }
  vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
      unstaged = "✚",
      stage = "✚",
      unmerged = "≠",
      renamed = "≫",
      untracked = "★"
    }
  }
end

return M
