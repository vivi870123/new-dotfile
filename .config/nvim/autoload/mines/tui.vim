" For Terminal User Interface (TUI) support
let s:shells = ['bash', 'zsh']
let s:tui_processes = ['htop', 'btm', 'broot', 'sr', 'ranger', 'nnn', 'vifm', 'fff', 'lf', 'lazygit', 'vtop']
let s:floaterm_wrappers = ['fff', 'fzf', 'lf', 'nnn', 'ranger', 'vifm', 'vtop']

function! mines#tui#get_shells()
  return s:shells
endfunction

function! mines#tui#get_processes()
  return s:tui_processes
endfunction

function! mines#tui#get_floaterm_wrappers()
  return s:floaterm_wrappers
endfunction

function! mines#tui#get_boundary_pattern(pattern)
  return '\<'.a:pattern.'\>'
endfunction

function mines#tui#is_tui(command)
  if index(s:floaterm_wrappers, a:command) != -1
    return v:true
  endif

  for tui_process in s:tui_processes
    if a:command =~ mines#tui#get_boundary_pattern(tui_process)
      return v:false
    endif
  endfor

  for shell in s:shells
    if a:command =~ mines#tui#get_boundary_pattern(shell)
      return v:false
    endif
  endfor

  return v:true
endfunction

" Functions
function! mines#tui#run(split, command)
  let split = a:split ==# 'float' ? 'float' : a:split

  if split ==# 'float'
    if mines#tui#is_tui(a:command)
      call floaterm#new(a:command, { 'autoclose': 1 }, {}, $SHELL)
    else
      call floaterm#terminal#open(-1, a:command, {}, {})
    endif
  else
    call floaterm#terminal#open(-1, a:command, {}, {
      \ 'wintype': 'normal', 
      \ 'position': 'right', 
      \ 'width': 70,
      \ 'autoclose': 1
      \ })
  endif
endfunction

" Use surfraw
function! mines#tui#google_keyword(keyword)
  if empty(a:keyword)
    return
  endif

  let command = 'sr google '.shellescape(a:keyword)
  call mines#tui#run('float', command)
endfunction
