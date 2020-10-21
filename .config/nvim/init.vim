if &compatible
  set nocompatible
endif

set t_Co=256
" enable true color

if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let $VIM_PATH = fnamemodify(resolve(expand('<sfile>:p')), ':h:h') . '/nvim'
let $DATA_PATH = g:etc#cache_path

augroup user_events
  autocmd!
  autocmd CursorHold *? syntax sync minlines=300
augroup END

" Disable vim distribution plugins {{{
"  let g:c_syntax_for_h = 1
"  let g:did_install_default_menus = 1
"  let g:loaded_2html_plugin = 1
"  let g:loaded_getscript = 1
"  let g:loaded_getscriptPlugin = 1
"  let g:loaded_gzip = 1
"  let g:loaded_logiPat = 1
"  " let g:loaded_netrw = 1
"  " let g:loaded_netrwFileHandlers  = 1
"  " let g:loaded_netrwPlugin        = 1
"  " let g:loaded_netrwSettings      = 1
"  let g:loaded_matchit = 1
"  let g:loaded_matchparen = 1
"  let g:netrw_nogx = 1 " disable netrw's gx mapping.
"  let g:loaded_rrhelper = 1  " ?
"  let g:loaded_shada_plugin = 1  " ?
"  let g:loaded_tar = 1
"  let g:loaded_tarPlugin = 1
"  let g:loaded_tutor_mode_plugin = 1
"  let g:loaded_vimball = 1
"  let g:loaded_vimballPlugin = 1  
"	let g:loaded_zip = 1
"  let g:loaded_zipPlugin = 1

" }}}

" Providers {{{
" Set them directly if they are installed, otherwise disable them. 
" To avoid the runtime check cost, which can be slow.
if has('nvim')
	" Python This must be here because it makes loading vim VERY SLOW otherwise
	let g:python_host_skip_check = 1
	if executable('python2')
		let g:python_host_prog = exepath('python2')
	else
		let g:loaded_python_provider = 0
	endif

	let g:python3_host_skip_check = 1
	if executable('python3')
		let g:python3_host_prog = exepath('python3')
	else
		let g:loaded_python3_provider = 0
	endif

	if executable('neovim-node-host')
		let g:node_host_prog = exepath('neovim-node-host')
	else
		let g:loaded_node_provider = 0
	endif

	if executable('neovim-ruby-host')
		let g:ruby_host_prog = exepath('neovim-ruby-host')
	else
		let g:loaded_ruby_provider = 0
	endif
endif

" }}}
" Initialize base requirements {{{
if has('vim_starting')
	" Use spacebar as leader and ; as secondary-leader
	" Required before loading plugins!
	let g:mapleader="\<Space>"
	let g:maplocalleader=';'

	" Release keymappings prefixes, evict entirely for use of plug-ins.
	nnoremap <Space>  <Nop>
	xnoremap <Space>  <Nop>
	nnoremap ,        <Nop>
	xnoremap ,        <Nop>
	nnoremap ;        <Nop>
	xnoremap ;        <Nop>
	nnoremap m        <Nop>
	xnoremap m        <Nop>

" Ensure data directories
call etc#util#ensure_directory([
				\   g:etc#cache_path    . '/undo',
				\   g:etc#cache_path    . '/backup',
				\   g:etc#cache_path    . '/session',
				\ ])
endif
" }}}

call etc#init()


call etc#util#source_file('config/settings.vim')
call etc#util#source_file('config/autocmds.vim')

call mines#theme#init()

call etc#util#source_file('config/color.vim')

lua require 'mines/init'

" After this file is sourced, plug-in code will be evaluated.
" See ~/.vim/after for files evaluated after that.
" See `:scriptnames` for a list of all scripts, in evaluation order
" Launch Vim with `vim --startuptime vim.log` for profiling info.
"
" To see all leader mappings, including those from plug-ins:

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :

" nnoremap <a-j> :echo('hello')
" nnoremap <a-a> ggVG
