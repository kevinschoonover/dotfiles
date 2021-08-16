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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'neovim/nvim-lspconfig'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'lervag/vimtex'

" hrsh7th/vim-vsnip
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NIM lua configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
luafile $HOME/.config/nvim/lua/init.lua

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dracula
set termguicolors

" vimtex
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'evince'
let g:vimtex_compiler_progname = 'nvr'

" tree sitter

" COC
set completeopt=longest,menuone

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
" set nobackup
" set nowritebackup

" Better display for messages
set cmdheight=1

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction
"
" " Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')
"
" " Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)
"
" " Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
"
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
"
" " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
"
" " Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)
"
" " Create mappings for function text object, requires document symbols feature of
" " languageserver.
"
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)
"
" " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)
"
" " Use `:Format` to format current buffer
" command! -nargs=0 Format :call CocAction('format')
"
" " Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
" " use `:OR` for organize import of current buffer
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"
" " Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
" " Using CocList
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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
color dracula

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
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()


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
autocmd BufWritePre *.yml,*.py,*.vim,*.css,*.js,*.html,*.cpp,*.c,*.java,*.go,*.rs,*.ts,*.cljs,*.clj,*.vue,*.tsx,*.ts,*.md,*.hcl :%s/\s\+$//e
" Fix for Django templates not being treated as HTML files
autocmd BufNewFile,BufRead *.vue :setlocal syntax=html sw=2 ts=2 sts=2
autocmd BufNewFile,BufRead *.html,*.ejs :setlocal syntax=html sw=2 ts=2 sts=2
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx sw=2 ts=2 sts=2
autocmd BufNewFile,BufRead *.hcl,*.nomad set sw=2 ts=2 sts=2


" File specific tab options
autocmd FileType html :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files "
autocmd FileType javascript :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files "
autocmd FileType typescript :setlocal makeprg=tsc sw=2 ts=2 sts=2
autocmd FileType python :setlocal sw=4 ts=4 sts=4
autocmd FileType yaml :setlocal sw=2 ts=2 sts=2 " Two spaces for YAML files "


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
