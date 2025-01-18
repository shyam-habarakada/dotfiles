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
  let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:15,results:15'

Plug 'mhinz/vim-startify'

Plug 'justinmk/vim-sneak'

Plug 'airblade/vim-gitgutter'

Plug 'zivyangll/git-blame.vim'
  nnoremap <C-b> :GitBlame<CR>

Plug 'iberianpig/tig-explorer.vim'

Plug 'github/copilot.vim'
  let g:copilot#enabled = 1

call plug#end()

" Bindings to trigger plugin management
nnoremap <leader>i :PlugInstall<CR>
nnoremap <leader>c :PlugClean<CR>

" end of vim-plug configuration
" -----------------------------------------------------------------------------


set autoindent
set autoread
set background=light
set backspace=indent,eol,start
set backupcopy=yes " Docker inotify issue workaround
set clipboard=unnamed
set cursorline
set expandtab
set fillchars+=vert:\  " Keep this comment so vim wont trim the trailing space
set foldmethod=syntax
set foldnestmax=4
set foldtext=CustomFoldText()
set hlsearch
set incsearch
set list " Tabs and trailing spaces
set listchars=tab:\|⋅,trail:⋅,nbsp:⋅
set nobackup
set nocompatible
set nofoldenable
set nowrap
set number
set pastetoggle=<F2>
set path=**
set relativenumber
set shiftwidth=2
set softtabstop=2
set splitright
set tabstop=2
set wildignore+=**/source_maps/**
set wildignore+=/usr/local/share/vim/**
set wildignore+=*.o,*.obj,*.zip,*~,*/log/*,*/tmp/*.*,*.log,*/.git/*
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildmode=longest:full   "make cmdline tab completion similar to bash


if has("mouse")
  set mouse=a
endif

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

function! CustomFoldText()
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
endfunction

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window.
autocmd InsertEnter * let w:last_fdm=&foldmethod | setlocal foldmethod=manual
autocmd InsertLeave * let &l:foldmethod=w:last_fdm

" Turn off search highlights and clear the curent search pattern when entering insert mode
autocmd InsertEnter * :set nohlsearch | let @/ = ""
autocmd InsertLeave * :set hlsearch

hi CursorColumn cterm=none ctermbg=LightGray
hi CursorLine cterm=none ctermbg=LightGray
hi CursorLineNr cterm=none ctermbg=LightGray
hi LineNr ctermfg=grey
hi Search ctermbg=LightBlue ctermfg=DarkGray
hi IncSearch ctermbg=LightBlue ctermfg=DarkGray
hi SignColumn cterm=none ctermbg=none

syntax enable

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
    copen
  else
    cclose
  endif
endfunction

map <silent> <C-l> :call ToggleQuickFix()<cr>
map <C-j> :cn<CR>
map <C-k> :cp<CR>
autocmd FileType qf setlocal norelativenumber

" shortcuts for toggling text wrap
map <C-t><C-w> :set wrap!<CR>
map <C-t>w :set wrap!<CR>

" Trim trailing space before saving
autocmd BufWritePre * :%s/\s\+$//e

" Use these file types by extension
autocmd BufNewFile,BufRead *.jst.eco set filetype=xml

" -----------------------------------------------------------------------------
" Extended behavior on top of git-blame.vim
"
" function! IsFileBuffer()
"     return bufname('%') !=# '' && getbufvar('%', '&buftype') ==# ''
" endfunction
"
" function! IsGitControlled()
"   if IsFileBuffer()
"     let l:filepath = expand('%:p')
"     let l:git_root = system('git rev-parse --show-toplevel 2>/dev/null')
"     " If the file is under git control
"     if v:shell_error == 0 && !empty(l:git_root)
"       return 1
"     else
"       return 0
"     endif
"   else
"     return 0
"   endif
" endfunction
"
" function! s:SafeGitBlame()
"   if IsFileBuffer() && IsGitControlled()
"     execute "GitBlame"
"   endif
" endfunction
"
" augroup VerticalMove
"   autocmd!
"   autocmd CursorHold * call s:SafeGitBlame()
" augroup END
"
" -----------------------------------------------------------------------------
