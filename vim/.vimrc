"===============================================================================
"  ___  _            _
" | . \| | _ _  ___ <_>._ _  ___
" |  _/| || | |/ . || || ' |<_-<
" |_|  |_|`___|\_. ||_||_|_|/__/
"              <___'
"===============================================================================

call plug#begin()
" Cosmetic
Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'joshdick/onedark.vim'
Plug 'dylanaraps/wal.vim'
Plug 'yggdroot/indentline'
Plug 'ap/vim-css-color'
Plug 'airblade/vim-gitgutter'
" Syntax
Plug 'pangloss/vim-javascript'
" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
" Useful
Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'markonm/traces.vim'
" Linting
Plug 'w0rp/ale'
" Fuzzy
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

"===============================================================================
"  ___                  ___       ___           _    _
" / __> ___ ._ _  ___  | . \ ___ | | '___  _ _ | | _| |_ ___
" \__ \<_> || ' |/ ._> | | |/ ._>| |-<_> || | || |  | | <_-<
" <___/<___||_|_|\___. |___/\___.|_| <___|`___||_|  |_| /__/
"
"===============================================================================
" Good start URL: http://vim.wikia.com/wiki/Example_vimrc

syntax on                              " Enable syntax highligting
set hidden                             " Can switch between unsaved buffers
set wildmenu                           " Better command-line completion
set showcmd                            " Show partial commands
set lazyredraw                         " Redraw screen less often
set hlsearch                           " Highlight searches
set incsearch                          " Show searches as you type
set ignorecase                         " Case insensitive search
set smartcase                          " Except when using capital letters
set gdefault                           " Global flag is now implied on regex
set backspace=indent,eol,start         " Allow backspace over anything
set autoindent                         " Always auto indent
set ruler                              " Display cursor position
set laststatus=2                       " Always display status line
set confirm                            " Confirm commands instead of failing
set visualbell                         " Visual bell instead of beeping
set t_vb=                              " No flashing
set mouse=a                            " Enable mouse everywhere
set number                             " Display line numbers
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
set encoding=utf-8                     " Set standard file encoding
set colorcolumn=80                     " Coloured column for long lines
set nowrap                             " No word wrapping
set splitbelow                         " Splits open below
set splitright                         " Splits open to the right
set nobackup                           " No backup files

" Have Y act like C and D
nnoremap Y y$
" Allow word under cursor refactoring
nnoremap c* *Ncgn
nnoremap c# #NcgN


" Deal with swap files
if !isdirectory($HOME . '/.vim/swap') && has('unix')
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=.swp/,~/.vim/swp//,/tmp//,.

" Deal with undo files
if exists('+undofile')
  if !isdirectory($HOME . '/.vim/undo') && has('unix')
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undofile
  set undodir=.undo/,~/.vim/undo//,/tmp//,.
endif

"===============================================================================
"  __ __        ___       ___           _    _
" |  \  \ _ _  | . \ ___ | | '___  _ _ | | _| |_ ___
" |     || | | | | |/ ._>| |-<_> || | || |  | | <_-<
" |_|_|_|`_. | |___/\___.|_| <___|`___||_|  |_| /__/
"        <___'
"===============================================================================

"use Mac OS X dictionary
if has('macunix')
  set dictionary=/usr/share/dict/words
endif

" Set vim to use bash for compatability
set shell=bash\ -i
if &diff
  set shell=bash
endif

" https://www.reddit.com/r/vim/wiki/tabstop
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab " use spaces instead of tabs

" The <Leader> key is pressed before any shortcut to trigger the command
let mapleader="\<SPACE>"

" Clear highlight and redraw screen
nnoremap <leader>hh :nohlsearch<CR>:redraw!<CR>
" Toggle spell checking
nnoremap <leader>ss :setlocal spell!<CR>

" Deal with the system clipboard
nnoremap <leader>y "*y
vnoremap <leader>y "*y
nnoremap <leader>p "*p
vnoremap <leader>p "*p
nnoremap <leader>P "*P

" Customizing the wildmenu
" https://stackoverflow.com/questions/16082991/vim-switching-between-files-rapidly-using-vanilla-vim-no-plugins
set wildmode=list:full
set wildignorecase
set wildignore=*.swp,*.bak
set wildignore+=*.pyc,*.cache,*.min.*
set wildignore+=*/.git/**/*,*/node_modules/**/*
set wildcharm=<C-z>

" Juggling with Files and Buffers
set path+=**
nnoremap <leader>l :Lines<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>s :sfind *
nnoremap <leader>v :vert sfind *
nnoremap <leader>t :tabfind *

" Only search under directory of current file
nnoremap <leader>F :find <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>S :sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>V :vert sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>T :tabfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>B :sbuffer <C-z><S-Tab>

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
function! StripTrailingWhitespace() abort
  if !&binary && &filetype != 'diff'
    let l:winview = winsaveview()
    silent! %s/\s\+$//e
    call winrestview(l:winview)
  endif
endfunction

nnoremap <leader>ww :call StripTrailingWhitespace()<CR>

" Change cursor shape in different modes
if has('macunix')
  " if you're using iTerm2
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  if !empty($TMUX)
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  endif
elseif has('unix') && !has('win32unix')
  " if you're using urxvt, st, or xterm
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
  if !empty($TMUX)
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>[6 q\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
  endif
endif

"===============================================================================
"  ___                                 _
" |  _> ___ ._ _ _ ._ _ _  ___ ._ _  _| | ___
" | <__/ . \| ' ' || ' ' |<_> || ' |/ . |<_-<
" `___/\___/|_|_|_||_|_|_|<___||_|_|\___|/__/
"
"===============================================================================

" Use ripgrep as default grep program
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

" Grep through directory with fzf and rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \ <bang>0)

" Jump between WebDev files
augroup WEBDEV
  autocmd!
  autocmd BufLeave *.css  normal! mC
  autocmd BufLeave *.html normal! mH
  autocmd BufLeave *.js   normal! mJ
  autocmd BufLeave *.php  normal! mP
  autocmd FileType JavaScript inoremap ;; <END>;
  autocmd FileType JavaScript inoremap ,, <END>,
augroup END

" Markdown setting changes
augroup Markdown
  autocmd!
  autocmd FileType markdown set colorcolumn=
  autocmd FileType markdown setlocal wrap
augroup END

" Automatically generate shortcuts after editing file
augroup ShortcutSync
  autocmd!
  if isdirectory("~/.scripts")
    autocmd BufWritePost ~/.scripts/folders,~/.scripts/configs !bash ~/.scripts/shortcuts.sh
  endif
augroup END

"===============================================================================
"  ___  _            _        ___        _   _   _
" | . \| | _ _  ___ <_>._ _  / __> ___ _| |_| |_<_>._ _  ___  ___
" |  _/| || | |/ . || || ' | \__ \/ ._> | | | | | || ' |/ . |<_-<
" |_|  |_|`___|\_. ||_||_|_| <___/\___. |_| |_| |_||_|_|\_. |/__/
"              <___'                                    <___'
"===============================================================================

" https://shapeshed.com/vim-netrw/
" Replace NERDtree with default netrw
nnoremap <leader><Tab> :Lexplore<CR>
let g:netrw_banner = 0       " disable banner
let g:netrw_liststyle = 3    " tree view
let g:netrw_altv = 1         " open splits to the right
let g:netrw_preview = 1      " open previews vertically
let g:netrw_winsize = 20     " make netrw take up 20% of the window
let g:netrw_list_hide = '.*\.swp,.git/'

let g:onedark_termcolors = 16
colorscheme onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#ale#enabled = 1
let g:airline_section_z = '%3p%% %{g:airline_symbols.linenr}%3l:%-2v'
let g:tmuxline_powerline_separators = 0
let g:indentLine_char = '|'
let g:javascript_plugin_jsdoc = 1
let g:indentLine_color_term = 15
let g:fzf_buffers_jump = 1

