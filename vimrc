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

set foldlevelstart=2
set foldmethod=syntax
set foldnestmax=2
set foldtext=CustomFoldText()

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window.
autocmd InsertEnter * let w:last_fdm=&foldmethod | setlocal foldmethod=manual
autocmd InsertLeave * let &l:foldmethod=w:last_fdm

set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
set autoindent
set number
set autoread
set incsearch
set nowrap
set backspace=indent,eol,start
set path=**

syntax enable

" Tabs and trailing spaces
set list
set listchars=tab:\|⋅,trail:⋅,nbsp:⋅

let g:solarized_termcolors=16
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"

" Requires https://github.com/powerline/fonts
" airline now works without these custom fonts
" let g:airline_powerline_fonts = 1
" let g:airline_theme = "solarized"

" For airline
set laststatus=2

let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_root_markers = '.git'
let g:ctrlp_working_path_mode = 'r'

call pathogen#infect()

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

if $TERM_PROGRAM == "Apple_Terminal"
  set background=dark
endif

colorscheme solarized

set wildmode=longest:full   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*.zip,*~,log/**,tmp/**,*.log,.git/**
set wildignore+=**/source_maps/**
set wildignore+=/usr/local/share/vim/**

"quick save
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a

autocmd BufWritePre * :%s/\s\+$//e

autocmd BufNewFile,BufRead *.jst.eco set filetype=xml

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif
