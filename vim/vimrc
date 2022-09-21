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
set foldmethod=syntax
set foldnestmax=4
set foldtext=CustomFoldText()

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

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

" Tabs and trailing spaces
set list
set listchars=tab:\|⋅,trail:⋅,nbsp:⋅

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

syntax enable

set background=light
set cursorline

colorscheme solarized

" Override CursorLineNr
hi CursorLineNr ctermbg=Cyan ctermfg=White


" The Silver Searcher and quickfix tweaks
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
