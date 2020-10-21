augroup user_plugin_filetype
	autocmd!

	" Do not use smart case in command line mode,
	" From: https://goo.gl/vCTYdK
	autocmd CmdLineEnter : set nosmartcase
	autocmd CmdLineLeave : set smartcase

	" automatically set read-only for files being edited elsewhere
	autocmd SwapExists * nested let v:swapchoice = 'o'

	" force write shada on leaving nvim
	autocmd VimLeave * if has('nvim') | wshada! | else | wviminfo! | endif

  " make splits equal in size
  autocmd VimResized * wincmd =

	" Equalize window dimensions when resizing vim window
	autocmd VimResized * tabdo wincmd =

	if has('folding')
		" like the autocmd described in `:h last-position-jump` but we add `:foldopen!`.
		autocmd BufWinEnter * if line("'\"") > 1 && line("'\"") <= line('$') | execute "normal! g`\"" | execute 'silent! ' . line("'\"") . 'foldopen!' | endif
	else
		autocmd BufWinEnter * if line("'\"") > 1 && line("'\"") <= line('$') | execute "normal! g`\"" | endif
	endif

	" when editing a file, always jump to the last known cursor position.
	" don't do it when the position is invalid or when inside an event handler
	autocmd BufReadPost *
		\ if &ft !~# 'commit' && ! &diff &&
		\      line("'\"") >= 1 && line("'\"") <= line("$")
		\|   execute 'normal! g`"zvzz'
		\| endif
	
	" Reload vim config automatically
	autocmd BufWritePost $VIM_PATH/{*.vim,*.yaml,vimrc} nested
		\ source $MYVIMRC | redraw

	" update filetype on save if empty
	autocmd BufWritePost * nested
		\ if &l:filetype ==# '' || exists('b:ftdetect')
		\ |   unlet! b:ftdetect
		\ |   filetype detect
		\ | endif

	" highlight the current line in the current window.
	autocmd BufEnter * set cursorline
	autocmd BufLeave * set cursorline
	autocmd InsertEnter * set nocursorline
	autocmd InsertLeave * set cursorline

  " See: https://github.com/neovim/neovim/issues/7994
  autocmd InsertLeave * set nopaste

	autocmd Syntax * if line('$') > 5000 | syntax sync minlines=200 | endif

  autocmd FileType gitcommit,gina-status,todo,qf setlocal cursorline

	autocmd FileType crontab setlocal nobackup nowritebackup

	autocmd FileType yaml.docker-compose setlocal expandtab

	autocmd FileType gitcommit,qfreplace setlocal nofoldenable

	" https://webpack.github.io/docs/webpack-dev-server.html#working-with-editors-ides-supporting-safe-write
	autocmd FileType css,javascript,jsx,javascript.jsx setlocal backupcopy=yes

	autocmd FileType php
		\ setlocal matchpairs-=<:> iskeyword+=\\ path+=/usr/bin/pear
		\ | setlocal formatoptions=qroct " correct indent after opening a phpdocblock

	autocmd FileType python
		\ setlocal foldmethod=indent expandtab smarttab nosmartindent
		\ | setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80

	autocmd FileType zsh setlocal foldenable foldmethod=marker

	autocmd FileType html setlocal path+=./;/

	autocmd FileType markdown
		\ setlocal expandtab conceallevel=0 wrap nonumber textwidth=80
		\ | setlocal autoindent formatoptions=tcroqn2 comments=n:>

	autocmd FileType apache setlocal path+=./;/

	autocmd FileType cam setlocal nonumber synmaxcol=10000

	" disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

	let g:QuitOnQ = ['preview', 'qf', 'fzf', 'netrw', 'help', 'taskedit', 'diff', 'startuptime']
	function! ShouldQuitOnQ() abort
		return &diff || index(g:QuitOnQ, &filetype) >= 0
	endfunction

  " close preview buffer with q
  autocmd FileType * if ShouldQuitOnQ() | nmap <buffer> <silent> <expr>  q &diff ? ':qa!<cr>' : ':q<cr>' | endif


	" when shortcut files are updated, renew bash and vifm configs with new material:
	autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts

	" run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

	autocmd BufWritePost config.h !sudo make install

	autocmd BufWritePost bspwmrc !i3-msg restart
	autocmd BufWritePost sxhkdrc !i3-msg restart
	autocmd BufWritePost picom.conf !i3-msg restart
	autocmd BufWritePost *ncmpcpp/config,*ncmpcpp/bindings !killall ncmpcpp ; st -e ncmpcpp &
	autocmd BufWritePost *polybar/config !i3-msg restart
	autocmd BufWritePost ~/.config/transmission-daemon/settings.json !killall -HUP transmission-da
augroup END


" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
