local vim = vim

local fzf_to_qf_ref = mines.utils.funcref:create(function (_, lines)
  mines.qf.build_list(lines)
end , { name = 'fzf_to_qf' })


local settings = {
  -- floaterm
  floaterm_position = 'center',
  floaterm_width = vim.fn.float2nr(vim.o.columns * 0.9),
  floaterm_height = vim.fn.float2nr(vim.o.lines * 0.75),
  floaterm_winblend = 10,
  floaterm_background = '#36353d',
  floaterm_autoclose = 2,

  -- FZF
  fzf_action = {
    ['ctrl-t'] = 'tab split',
    ['ctrl-x'] = 'split',
    ['ctrl-v'] = 'vsplit',
  },
  fzf_layout= { window = mines.fzf.float_window() },
  fzf_files_options = [[--bind 'ctrl-l:execute(bat --paging=always {} > /dev/tty)']],
  fzf_preview_floating_window_winblend = 10,

  -- FzfPreview
  fzf_preview_fzf_preview_window_option = 'right:50%'
}

mines.command [[highlight NormalFloat cterm=NONE ctermfg=14 ctermbg=0 gui=NONE guifg=#93a1a1 guibg=#36353d]]

for key,value in pairs(settings) do
  vim.g[key] = value
end
