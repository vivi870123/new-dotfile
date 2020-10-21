" append modeline after last line in buffer
" See: http://vim.wikia.com/wiki/Modeline_magic
function! mines#mappings#append_modeline() abort
  let l:modeline = printf(' vim: set foldmethod=marker ts=%d sw=%d tw=%d %set :',
    \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
  call append(line('$'), l:modeline)
endfunction

" returns visually selected text
function! mines#mappings#get_selection(cmdtype) abort
  let temp = @s
  normal! gv"sy
  let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
  let @s = temp
endfunction

function! mines#mappings#execute_macro_over_visual_range() abort
  echo '@'.getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

function! mines#mappings#open() abort
  " Linux/BSD
  if executable('xdg-open')
    return 'xdg-open'
  endif
  " MacOS
  if executable('open')
    return 'open'
  endif
  " Windows
  return 'explorer'
endfunction

function! mines#mappings#open_file_folder() abort
  silent call system(mines#mappings#open() . ' '.expand('%:p:h:~'))
endfunction

function! mines#mappings#close_buffer(...) abort
  if &buftype !=? ''
    return execute('q!')
  endif
  let l:windowCount = winnr('$')
  let l:totalBuffers = len(getbufinfo({ 'buflisted': 1 }))
  let l:noSplits = l:windowCount ==? 1
  let l:bang = a:0 > 0 ? '!' : ''
  if l:totalBuffers > 1 && l:noSplits
    let l:command = 'bp'
    if buflisted(bufnr('#'))
      let l:command .= '|bd'.l:bang.'#'
    endif
    return execute(l:command)
  endif
  return execute('q'.l:bang)
endfunction

function! mines#mappings#tab_move_by(indexDiff) abort
  let nextTabIndex = tabpagenr() + a:indexDiff
  let lastTabIndex = tabpagenr('$')
  if nextTabIndex > lastTabIndex
    let nextTabIndex = 0
  elseif nextTabIndex < 0
    let nextTabIndex = lastTabIndex
  endif
  execute 'tabmove ' . nextTabIndex
endfunction


function! mines#mappings#toggle_background() abort
  if ! exists('g:colors_name')
    echomsg 'No colorscheme set'
    return
  endif
  let l:scheme = g:colors_name

  if l:scheme =~# 'dark' || l:scheme =~# 'light'
    " rotate between different theme backgrounds
    execute 'colorscheme' (l:scheme =~# 'dark'
            \ ? substitute(l:scheme, 'dark', 'light', '')
            \ : substitute(l:scheme, 'light', 'dark', ''))
  else
    execute 'set background='.(&background ==# 'dark' ? 'light' : 'dark')
    if ! exists('g:colors_name')
      execute 'colorscheme' l:scheme
      echomsg 'The colorscheme `'.l:scheme
              \ .'` doesn''t have background variants!'
    else
      echo 'Set colorscheme to '.&background.' mode'
    endif
  endif
endfunction

function! mines#mappings#toggle_contrast(delta) abort
  let l:scheme = ''
  if g:colors_name =~# 'solarized8'
    let l:schemes = map(['_low', '_flat', '', '_high'], '"solarized8_".(&background).v:val')
    let l:contrast = ((a:delta + index(l:schemes, g:colors_name)) % 4 + 4) % 4
    let l:scheme = l:schemes[l:contrast]
  endif
  if l:scheme !=# ''
    execute 'colorscheme' l:scheme
  endif
endfunction
