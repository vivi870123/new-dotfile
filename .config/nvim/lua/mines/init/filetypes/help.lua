local mappings = require 'mines/utils/mappings'
local vim = vim

return function()
  mappings.register_buffer_mappings {
    ['n q'] = { [[:quit<cr>]], silent=true, noremap=true, description = 'Quit' },
    ['n m<CR>'] = { [[<C-]>]], description = 'Jump to link' },
    ['n m<BS>'] = { [[<C-T>]], description = 'Jump back' },
    ['n mo'] = { [[/'[a-z]\{2,\}'<CR>]], noremap=true, description = 'Skip to option link' },
    ['n mO'] = { [[?'[a-z]\{2,\}'<CR>]], noremap=true, description = 'Skip to option link' },
    ['n mf'] = { [[/\|\S\+\|<CR>l]], noremap=true, description = 'Skip to next subject link' },
    ['n mF'] = { [[h?\|\S\+\|<CR>l]], noremap=true, description = 'Skip to next subject link' },
    ['n mt'] = { [[/\*\S\+\*<CR>l]], noremap=true, description = 'Skip to next tag (subject anchor)' },
    ['n mT'] = { [[h?\*\S\+\*<CR>l]], noremap=true, description = 'Skip to prev tag (subject anchor)' },

    ['nq'] = { [[:quit<cr>]], silent=true, noremap=true, description = 'Quit' },
    ['n<CR>'] = { [[<C-]>]], description = 'Jump to link' },
    ['n<BS>'] = { [[<C-T>]], description = 'Jump back' },
    ['no'] = { [[/'[a-z]\{2,\}'<CR>]], noremap=true, description = 'Skip to option link' },
    ['nO'] = { [[?'[a-z]\{2,\}'<CR>]], noremap=true, description = 'Skip to option link' },
    ['nf'] = { [[/\|\S\+\|<CR>l]], noremap=true, description = 'Skip to next subject link' },
    ['nF'] = { [[h?\|\S\+\|<CR>l]], noremap=true, description = 'Skip to next subject link' },
    ['nt'] = { [[/\*\S\+\*<CR>l]], noremap=true, description = 'Skip to next tag (subject anchor)' },
    ['nT'] = { [[h?\*\S\+\*<CR>l]], noremap=true, description = 'Skip to prev tag (subject anchor)' },
  };

end
