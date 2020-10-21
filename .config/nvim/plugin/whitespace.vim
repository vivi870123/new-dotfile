
" Whitespace utilities
" ---

" strips trailing whitespace at the end of files.
function! Preserve(command) abort
  " Preparation: save last search, and cursor position.
  let l:pos=winsaveview()
  let l:search=@/
  " Do the business:
  keeppatterns execute a:command
  " Trim trailing blank lines
  " keeppatterns %s#\($\n\s*\)\+\%$##
  " Clean up: restore previous search history, and cursor position
  let @/=l:search
  nohlsearch
  call winrestview(l:pos)
endfunction

let s:keep_white_space = ['markdown']

augroup my_whitespace
  autocmd!
  " Ale is handling this currently
  " autocmd BufWritePre * if utils#should_strip_whitespace(s:keep_white_space) | call utils#Preserve("%s/\\s\\+$//e") | endif
augroup END

command! StripTrailingWhitespace call utils#Preserve("%s/\\s\\+$//e")
command! Reindent call utils#Preserve("normal gg=G")

nnoremap _= :Reindent<cr>

" Remove spaces at the end of lines
nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>











" vim: set ts=2 sw=2 tw=80 noet :


