execute 'luafile ' . stdpath('config') . '/lua/mines/plugins.lua'
command! PackerInstall packadd packer.nvim | lua require('mines/plugins').install()
command! PackerUpdate packadd packer.nvim  | lua require('mines/plugins').update()
command! PackerSync packadd packer.nvim    | lua require('mines/plugins').sync()
command! PackerClean packadd packer.nvim   | lua require('mines/plugins').clean()
command! PackerCompile packadd packer.nvim | lua require('mines/plugins').compile('~/.config/nvim/plugin/packer_load.vim')

packadd! auto-git-diff
packadd! committia.vim
packadd! goyo.vim
packadd! indentLine
packadd! iron.nvim
packadd! limelight.vim
packadd! nvim-colorizer.lua
packadd! packer.nvim
packadd! ultisnips
packadd! undotree
packadd! vim-dispatch
packadd! vim-doge
packadd! vim-gitgutter
packadd! vim-floaterm
packadd! vim-fugitive
packadd! vim-matchup
packadd! vimagit
packadd! vimwiki

lua require 'mines/init'
