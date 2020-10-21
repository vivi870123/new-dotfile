" Snippets from vim-help
" Credits: https://github.com/dahu/vim-help

if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

let b:undo_ftplugin = 'setlocal spell<'
setlocal nospell

setlocal nolist
setlocal nohidden
setlocal iskeyword+=:
setlocal iskeyword+=#
setlocal iskeyword+=-

if winnr('$') > 2 + (bufname('coc-explorer') ==# '' ? 0 : 1)
	wincmd K
else
	wincmd L
endif


let &cpoptions = s:save_cpo
" vim: set ts=2 sw=2 tw=80 noet :
