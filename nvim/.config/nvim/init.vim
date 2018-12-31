""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"   => Plugins
"       -> Plugin Settings
"   => General
"   => Vim Interface
"   => Colors and Fonts
"   => Text, tab, and indent related
"   => Keybind Remaps
"   => Commands
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')
Plug 'w0rp/ale' " Asynchronous Lint Engine
Plug 'Chiel92/vim-autoformat', { 'on': 'Autoformat' } " Automatic Code Formatter
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'posva/vim-vue'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Only run ALE on file save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" How many lines of history VIM has to remember
set history=500

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
" Allow plugins by file type
filetype plugin on
filetype indent on

" Auto read and write
set autowrite
set autoread

" Better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backupdir=~/.vim/dirs/backups " where to put backup files
set backup                        " make backup files
set undodir=~/.vim/dirs/undodir   " undo directory
set undofile                      " persistent undos - undo after you re-open the file

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stop messing with the cursor
" set guicursor=

" Set hidden
set hidden

" Hidden startup messages
set shortmess=atI

" Highlight cursor line (slows down)
set nocursorline

" Disable wrapping
set nowrap

" Confirm before quit without save
set confirm

" Highlighted search results
set hlsearch

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Makes search act like search in modern browsers
set incsearch

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Redraw only when essential
set lazyredraw

" We don't care what mode we're in (Don't display mode on bottom)
set noshowmode

" Show invisibles
set list
set listchars=tab:\ \ ,eol:¬,trail:⋅
" autocmd ColorScheme * highlight NonText ctermfg=238 guifg=#444444

" When scrolling, keep cursor 5 lines away from screen border
set scrolloff=5

" Setting up wildmenu
set wildmenu
set wildmode=full

" Setting up ignores
set wildignore+=*/tmp/*,*.so,*.pyc,*.png,*.jpg,*.gif,*.jpeg,*.ico,*.pdf
set wildignore+=*.wav,*.mp4,*.mp3
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*
set wildignore+=_pycache_,.DS_Store,.vscode,.localized
set wildignore+=*/.git/*

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax Highlight
syntax on
color ron

" Set encoding to utf8
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set text over 80 characters Error color
set colorcolumn=81

" Set autowrap to 80 characters
set textwidth=80

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab, and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Linebreak on 500 characters
set lbr

"NoWrap lines
set nowrap

" Folding features
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keybind Remaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use the clipboard for copy and paste
" nnoremap y "+y
" nnoremap Y "+y$
" nnoremap p "+p`]
" nnoremap P "+P`]
" vnoremap y "+y
" vnoremap Y "+Y
" vnoremap p "+p
" vnoremap P "+P

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Easier indentation - does dot loose selection
vnoremap > >gv
vnoremap < <gv

autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.org setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell
autocmd FileType gitcommit setlocal spell
autocmd FileType help setlocal nospell

" Strip trailing whitespaces
function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
      normal mz
      %s/\s\+$//e
      normal `z
    endif
endfunction
command! StripTrailingWhitespace :call StripTrailingWhitespace()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart colorcolumn
highlight ColorColumn ctermbg=154 ctermfg=0 guibg=#474747 guifg=#ffffff
highlight CursorLine ctermbg=154 guibg=#474747
autocmd BufEnter * call matchadd('ColorColumn', '\%160v', 100)

" Better coloring for errors
hi clear SpellBad
hi SpellBad cterm=underline gui=underline ctermfg=11 guifg=#ffff00

" Resize panes whenever containing window resized.
autocmd VimResized * wincmd =

" Fix Caps messups
command! WQ wq
command! Wq wq
command! W w

" Remove trailing whitespace at save
autocmd BufWritePre *.py,*.vim,*.css,*.js,*.html,*.cpp,*.c,*.java,*.go,*.rs,*.ts,*.cljs,*.clj :%s/\s\+$//e
" Fix for Django templates not being treated as HTML files
autocmd BufNewFile,BufRead *.vue :setlocal syntax=html sw=2 ts=2 sts=2
autocmd BufNewFile,BufRead *.html :setlocal syntax=html sw=2 ts=2 sts=2

" File specific tab options
autocmd FileType html :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files "
autocmd FileType javascript :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files "
autocmd FileType typescript :setlocal makeprg=tsc sw=2 ts=2 sts=2

autocmd FileType tex :setlocal spell sw=2 ts=2 sts=2
autocmd FileType yacc :setlocal spell sw=2 ts=2 sts=2
autocmd FileType tex :syntax spell toplevel

set viminfo='20,<1000

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

