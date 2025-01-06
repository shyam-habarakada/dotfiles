" -----------------------------------------------------------------------------
" vim-plug setup and configuration

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'altercation/vim-colors-solarized'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 0
  let g:airline_theme = "solarized"

Plug 'ctrlpvim/ctrlp.vim'
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_cmd = 'CtrlPMRU'
  let g:ctrlp_root_markers = '.git'

Plug 'mhinz/vim-startify'

Plug 'justinmk/vim-sneak'

Plug 'airblade/vim-gitgutter'

Plug 'iberianpig/tig-explorer.vim'

Plug 'github/copilot.vim'
  let g:copilot#enabled = 1

call plug#end()

" end of vim-plug configuration
" -----------------------------------------------------------------------------

set nocompatible
set nobackup

"docker inotify issue workaround
set backupcopy=yes

set clipboard=unnamed
set pastetoggle=<F2>

if has("mouse")
  set mouse=a
endif

fu! CustomFoldText()
  "get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif
  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  let foldLevelStr = repeat("+--", v:foldlevel)
  let lineCount = line("$")
  let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
  let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
  return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf

set nofoldenable
set foldmethod=indent
set foldnestmax=5
set foldtext=CustomFoldText()

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window.
autocmd InsertEnter * let w:last_fdm=&foldmethod | setlocal foldmethod=manual
autocmd InsertLeave * let &l:foldmethod=w:last_fdm

autocmd InsertEnter * :set nohlsearch
autocmd InsertLeave * :set hlsearch

set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
set autoindent
set number
set relativenumber
set autoread
set incsearch
set nowrap
set backspace=indent,eol,start " This is a test.
set path=**

" Tabs and trailing spaces
set list
set listchars=tab:\|⋅,trail:⋅,nbsp:⋅

syntax enable
set background=light
colorscheme solarized

" Cterm Colors https://gist.github.com/meskarune/1db61ed782143c4dc0f35dbfc7f7a336

hi CursorLine cterm=none ctermbg=LightGray
hi CursorLineNr cterm=none ctermbg=LightGray
hi CursorColumn cterm=none ctermbg=LightGray
hi LineNr ctermfg=grey
hi SignColumn cterm=none ctermbg=LightGray
hi Search ctermbg=LightBlue ctermfg=DarkGray

" remove noise from window separator
set fillchars-=vert:\|
hi VertSplit ctermfg=LightGray

if has('nvim')
  " neovim appears to default insert mode to a line cursor (annoying)
  set guicursor=n-v-i-c:block
endif

" The Silver Searcher :and quickfix tweaks
if executable('ag')
  " bind \ (backward slash) to grep shortcut
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>

  set grepprg=ag\ --nogroup\ --nocolor

  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


function! ToggleQuickFix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    vertical copen
  else
    cclose
  endif
endfunction

" shortcuts for navigating quickfix results https://stackoverflow.com/a/29287066/850996
map <silent> <C-l> :call ToggleQuickFix()<cr>
map <C-p> :cp<CR>
map <C-n> :cn<CR>

" only highlight the current line on the active split (window)
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

" highlight current line by default
set cul

" shortcuts for toggling text wrap
map <C-t><C-w> :set wrap!<CR>
map <C-t>w :set wrap!<CR>

" settings and shortcuts for vim splits
set splitright

set wildmode=longest:full   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*.zip,*~,log/**,tmp/**,*.log,.git/**
set wildignore+=**/source_maps/**
set wildignore+=/usr/local/share/vim/**

autocmd BufWritePre * :%s/\s\+$//e

autocmd BufNewFile,BufRead *.jst.eco set filetype=xml

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif
