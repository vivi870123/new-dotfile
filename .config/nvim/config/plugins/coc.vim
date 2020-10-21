let g:coc_force_debug = 1
let g:coc_auto_open = v:false
let coc_disable_transparent_cursor = 1

augroup user_plugin_load_autocommands
	autocmd!
	autocmd VimEnter * call s:load_coc()
augroup END

" Packages {{{
function! s:load_coc() abort
	let g:coc_global_extensions = [
					\ 'coc-actions',
					\ 'coc-calc',
					\ 'coc-css',
					\ 'coc-diagnostic',
					\ 'coc-docthis',
					\ 'coc-emmet',
					\ 'coc-eslint',
					\ 'coc-git',
					\ 'coc-gitignore',
					\ 'coc-highlight',
					\ 'coc-html',
					\ 'coc-lists',
					\ 'coc-jest',
					\ 'coc-json',
					\ 'coc-markdownlint',
					\ 'coc-marketplace',
					\ 'coc-phpls',
					\ 'coc-prettier',
					\ 'coc-project',
					\ 'coc-python',
					\ 'coc-sh',
					\ 'coc-snippets',
					\ 'coc-spell-checker',
					\ 'coc-sql',
					\ 'coc-syntax',
					\ 'coc-tsserver',
					\ 'coc-ultisnips',
					\ 'coc-vimlsp',
					\ 'coc-word',
					\ 'coc-yaml',
					\ 'coc-yank',
					\ ]
	" }}}

	autocmd CursorHold *	silent call CocActionAsync('highlight')
	autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')

	augroup user_plugin_coc
		autocmd!

		autocmd BufWritePost coc.vim source % | CocRestart

		autocmd FileType python,rust call s:map_function_objects()
		autocmd FileType python let b:coc_root_patterns = ['pyproject.toml', '.git', '.env']

		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setl formatexpr=CocActionAsync('formatSelected')

		autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

		"python lsp config
		if dein#tap('python-syntax')
				let g:python_highlight_all = 1
		endif
	augroup END
endfunction


" Mappings {{{
" --------
" <c-x><c-g>: start ultisnips completion
inoremap <silent> <C-X><C-G> <C-R>=coc#start({ 'source': 'ultisnips' })<CR>


" Extensions
" ----------

" coc-git
" -------
nmap <silent> <expr> [c &diff ? '[c' : '<Plug>(coc-git-prevchunk)'
nmap <silent> <expr> ]c &diff ? ']c' : '<Plug>(coc-git-nextchunk)'
nmap <leader>hi <Plug>(coc-git-chunkinfo)
nnoremap <leader>hs :CocCommand git.chunkStage<cr>
nnoremap <leader>hu :CocCommand git.chunkUndo<cr>

" coc-snippet
" -----------
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'


" Commands
" --------
" Use `:Format` to format current buffer
command! -nargs=0 Prettier	:CocCommand prettier.formatFile
" Use `:Fold` to fold current buffer
command! -nargs=? Fold			:call CocActionAsync('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR				:call CocActionAsync('runCommand', 'editor.action.organizeImport')


" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
