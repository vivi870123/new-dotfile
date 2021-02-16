local sys = mines.sys
local nvim = mines.nvim
local files = mines.util.files

local set_grep = mines.helper.set_grep

local parent     = sys.data
local mkdir      = files.mkdir
local is_dir     = files.is_dir
local executable = files.executable


local cache_dir = os.getenv("HOME") .. "/.cache/vim";

local cmd = vim.api.nvim_command
local apply_settings = function(opts)
  for k, v in pairs(opts) do
    if v == true then
      cmd('set ' .. k)
    elseif v == false then
      cmd(string.format('set no%s', k))
    else
      cmd(string.format('set %s=%s', k, v))
    end
  end
end

local wildignores = {
  '*.spl', '*.aux', '*.out', '*.o', '*.pyc', '*.gz', '*.pdf', '*.sw',
  '*.swp', '*.swap', '*.com', '*.exe', '*.so', '*/cache/*', '*/__pycache__/*',
}

local no_backup = {
  '.git/*', '.svn/*', '.xml', '*.log', '*.bin', '*.7z', '*.dmg', '*.gz', '*.iso',
  '*.jar', '*.rar', '*.tar', '*.zip', 'TAGS', 'tags', 'GTAGS', 'COMMIT_EDITMSG',
  "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
}


local settings = {
  --[ General ]--
  termguicolors  = true;
  encoding       = "utf-8";
  modeline       = true;
  magic          = true;
  errorbells     = true;
  visualbell     = true;
  hidden         = true;
  autoread       = true;
  virtualedit    = "block";
  path           = '.,**';
  emoji          = false;

  --[ Vim Directories ]--
  undofile       = true;
  swapfile       = false;
  backup         = false;
  writebackup    = false;
  directory      = cache_dir .. "/swap/";
  undodir        = cache_dir .. "/undo/";
  backupdir      = cache_dir .. "/backup/";
  viewdir        = cache_dir .. "/view/";
  spellfile      = cache_dir .. "/spell/en.uft-8.add";
  viewoptions    = "folds,cursor,curdir,slash,unix";
  sessionoptions = "curdir,help,tabpages,winsize";
  backupskip     = table.concat(no_backup, ',') .. ',' .. table.concat(wildignores, ',');
  clipboard      = "unnamedplus";

  --[ Wildmenu ]--
  wildignorecase = true;
  wildignore     = table.concat(wildignores, ',');

  --[ History saving ]--
  history        = 2000;
  shada          = "!,/1000,'1000,<1000,:1000,s10000,h,r/tmp/";

  --[ Tab & Indent ]--
  smarttab       = true;
  shiftround     = true;
  -- shiftround     = false;

  --[ Searching ]--
  ignorecase     = true;
  smartcase      = true;
  infercase      = true;
  incsearch      = true;
  inccommand     = "nosplit";
  complete       = '.,b,w,u,k';
  wrapscan       = true;

  --[ Timing ]--
  timeout        = true;
  ttimeout       = true;
  timeoutlen     = 500;
  ttimeoutlen    = 10;
  updatetime     = 100;
  redrawtime     = 1500;

  --[ Behaviour ]--
  startofline    = false;
  whichwrap      = "h,l,<,>,[,],~";
  splitbelow     = true;
  splitright     = true;
  completeopt    = "menu,menuone,noselect";
  -- completeopt    = "menu,menuone,noselect,noinsert";
  jumpoptions    = "stack";
  switchbuf      = "useopen";
  backspace      = "indent,eol,start";
  diffopt        = "filler,iwhite,internal,algorithm:patience";
  grepformat     = "%f:%l:%c:%m";
  foldlevelstart = 99;
  scrollback     = 100000;

  --[ UI Options ]--
  showcmd        = false;
  showmode       = false;
  laststatus     = 2;
  ruler          = false;
  fileformats    = "unix,mac,dos";
  mouse          = "nv";
  shortmess      = "flinxtaoOTIcF";
  scrolloff      = 2;
  sidescrolloff  = 5;
  list           = false;
  listchars      = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←";
  showtabline    = 2;
  winwidth       = 30;
  winminwidth    = 10;
  pumheight      = 15;
  helpheight     = 12;
  previewheight  = 12;
  cmdheight      = 2;
  cmdwinheight   = 5;
  equalalways    = false;
  display        = "lastline";
  showbreak      = "↳  ";
  pumblend       = 10;
  winblend       = 10;

  breakindentopt = "shift:2,min:20";
  wrap           = false;
  synmaxcol      = 2500;
  formatoptions  = "1jcroqlnt";
  textwidth      = 80;
  expandtab      = true;
  autoindent     = true;
  tabstop        = 2;
  shiftwidth     = 2;
  softtabstop    = -1;
  linebreak      = true;
  number         = true;
  colorcolumn    = "80";
  foldenable     = true;
  signcolumn     = "yes";
  conceallevel   = 2;
  concealcursor  = "niv";
}

nvim.g.c_syntax_for_h = 0
nvim.g.c_comment_strings = 1
nvim.g.c_curly_error = 1
nvim.g.c_no_if0 = 0


-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim-treesitter#foldexpr()'

vim.o.breakat    = [[\ \      ;:,!?]]
vim.o.grepprg    = 'rg --hidden --vimgrep --smart-case --';
vim.o.rulerformat = [[%-14.(%l,%c   %o%)]];
vim.o.complete   = ".,w,b,k";


vim.g.terminal_scrollback_buffer_size = 100000;

set_grep(false, false)


if executable('nvr') then
  nvim.env.nvr  = 'nvr --servername '.. nvim.v.servername ..' --remote-silent'
  nvim.env.tnvr = 'nvr --servername '.. nvim.v.servername ..' --remote-tab-silent'
  nvim.env.vnvr = 'nvr --servername '.. nvim.v.servername ..' -cc vsplit --remote-silent'
  nvim.env.snvr = 'nvr --servername '.. nvim.v.servername ..' -cc split --remote-silent'
end

apply_settings(settings)
