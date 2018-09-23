call plug#begin('~/.vim/plugged')

" Show symbols in the gutter for git edits
Plug 'airblade/vim-gitgutter'
    set signcolumn=yes
    " Update vimgutter more frequently
    set updatetime=200

" gs to split lines, gj to join lines
Plug 'AndrewRadev/splitjoin.vim'

" cpp syntax highlighting
Plug 'bfrg/vim-cpp-modern'
    let g:cpp_simple_highlight = 1

" clang format
Plug 'rhysd/vim-clang-format'
    autocmd FileType c,cpp,objc nnoremap <c-l> :<C-u>ClangFormat<CR>
    autocmd FileType c,cpp,objc vnoremap <c-l> :ClangFormat<CR>

" airline for tmux
Plug 'edkolev/tmuxline.vim'

" statusbar line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plug 'itchyny/lightline.vim'

" Magit (Git wrapper) for vim
Plug 'jreybert/vimagit'
    let g:magit_discard_untracked_do_delete=1 

" Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
    " Customize fzf colors to match your color scheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

    let g:fzf_layout = { 'down': '~30%' }
    function! FzfFindFiles()
        if system('git rev-parse --is-inside-work-tree') =~ 'true'
            :GFiles
        else 
            :Files
        end
    endfunction

    nnoremap <c-p> :call FzfFindFiles()<CR>
    inoremap <c-p> :call FzfFindFiles()<CR>
    vnoremap <c-p> :call FzfFindFiles()<CR>

    nnoremap <c-b> :Buffers<CR>
    inoremap <c-b> :Buffers<CR>
    vnoremap <c-b> :Buffers<CR>

    nnoremap <c-f> :Ag<CR>
    inoremap <c-f> :Ag<CR>
    vnoremap <c-f> :Ag<CR>

" Align lines by regex/character
Plug 'junegunn/vim-easy-align'
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)

" Enhanced buffer search (eg. Automatically clear highlight)
Plug 'junegunn/vim-slash'

" Automatically close pairs {[(, etc
Plug 'jiangmiao/auto-pairs'

" Language pack for multiple languages
Plug 'sheerun/vim-polyglot'

" If available, show docs in statusbar
Plug 'Shougo/echodoc.vim'
    let g:echodoc_enable_at_startup = 1
    let g:echodoc#enable_force_overwrite = 1
      " Let echodoc consume --INSERT-- etc in the status bar 
    set laststatus=2
    "set cmdheight=2

" Add multiple cursors (Ctrl N)
Plug 'terryma/vim-multiple-cursors'

" Vim client (use for FZF Commits)
Plug 'tpope/vim-fugitive'

" Add surround motion
Plug 'tpope/vim-surround'

" Add hightlighting of words when searching using F/T
Plug 'unblevable/quick-scope'
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Linter
"Plug 'w0rp/ale'
"let g:ale_sign_column_always=1
"let g:ale_completion_enabled = 1
"let b:ale_set_balloons=1
"
"let g:ale_c_build_dir = ['build']
"let g:ale_c_parse_compile_commands=1

" Add extra text objects to enhance vim motions
Plug 'wellle/targets.vim'

" Highlight when line length exceeds limit
Plug 'whatyouhide/vim-lengthmatters'

" Show indent lines
Plug 'Yggdroot/indentLine'

" Add buffer tabs
"Plug 'zefei/vim-wintabs'

" <C-W>o to maximize/minimize windows
Plug 'troydm/zoomwintab.vim'

" Colorschemes
Plug 'joshdick/onedark.vim'
Plug 'kaicataldo/material.vim'
Plug 'kristijanhusak/vim-hybrid-material'

" NVIM Only
" Asynchronous autocomplete
if has("nvim")
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }

    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2', { 'do': ':UpdateRemotePlugins' }
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-neoinclude' | Plug 'Shougo/neoinclude.vim'

    let g:LanguageClient_serverCommands = {
    \ 'cpp': ['/home/zain/Projects/cpp/ccls/Release/ccls', 
    \         '--log-file=/tmp/clss.log'],
    \ 'c': ['/home/zain/Projects/cpp/ccls/Release/ccls']
    \ }

    let g:LanguageClient_autoStart = 1  

    set completefunc=LanguageClient#complete
    set formatexpr=LanguageClient_textDocument_rangeFormatting()

    nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
    nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
    nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

    Plug 'ncm2/ncm2-ultisnips'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=noinsert,menuone,preview ",noselect
    set shortmess+=c

    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif

    inoremap <expr> <CR> pumvisible() ? ncm2_ultisnips#expand_or("", 'n') : "\<CR>"
    "inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
    "inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

    endif

call plug#end()

""""""
" UI "
""""""

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
    set termguicolors
endif

" Lightline takes care of showing VIM mode for us, so we can disable the statusline
set noshowmode

set background=dark
" let g:lightline = { 'colorscheme' : 'material_vim' }
let g:airline_powerline_fonts = 1 
let g:airline_theme = 'material'
let g:material_theme_style = 'dark'
let g:airline#extensions#tabline#enabled = 1

colorscheme material

syntax on

"""""""""""
" General "
"""""""""""

" MatchParen makes paren highlight color confusing.
highlight MatchParen gui=bold guibg=NONE guifg=lightblue cterm=bold ctermbg=NONE

" keep selected text selected when fixing indentation
vnoremap < <gv
vnoremap > >gv

" lazyredraw, be faster (dont know any drawbacks?)
" set lazyredraw

" disable vi compatibility
set nocompatible

" automatically load changed files
set autoread

set noswapfile

" Buffers require saving before switching around. Hidden disables that.
set hidden

" auto-reload vimrc
autocmd! bufwritepost vimrc source ~/.vim/vimrc
"autocmd! bufwritepost gvimrc source ~/.vim/gvimrc

" show the filename in the window titlebar
set title

" set encoding
set encoding=utf-8

" display incomplete commands at the bottom
set showcmd

" mouse support
set mouse=a

" line numbers
set number

" highlight cursor line
" set cursorline

" wrapping stuff
set textwidth=120
set colorcolumn=120

" ignore whitespace in diff mode
set diffopt+=iwhite

" Be able to arrow key and backspace across newlines
set whichwrap=bs<>[]

" remember last cursor position
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\ 	exe "normal g`\"" |
	\ endif

" show '>   ' at the beginning of lines that are automatically wrapped
set showbreak=>\ \ \ 

" enable completion
"set ofu=syntaxcomplete#Complete

" make laggy connections work faster
set ttyfast

" let vim open up to 100 tabs at once
set tabpagemax=100

" case-insensitive filename completion
set wildignorecase

"""""""""""""
" Searching "
"""""""""""""

set hlsearch "when there is a previous search pattern, highlight all its matches
set incsearch "while typing a search command, show immediately where the so far typed pattern matches
set ignorecase "ignore case in search patterns
set smartcase "override the 'ignorecase' option if the search pattern contains uppercase characters
set gdefault "imply global for new searches

"""""""""""""
" Indenting "
"""""""""""""

" When auto-indenting, use the indenting format of the previous line
set copyindent
" When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
" 'tabstop' is used in other places. A <BS> will delete a 'shiftwidth' worth of
" space at the start of the line.
set smarttab
" Copy indent from current line when starting a new line (typing <CR> in Insert
" mode or when using the "o" or "O" command)
set autoindent
" Automatically inserts one extra level of indentation in some cases, and works
" for C-like files
set smartindent

set tabstop=8 softtabstop=0 expandtab shiftwidth=4

autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab

"""""""""""""""""""""
" Language-Specific "
"""""""""""""""""""""

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Add json syntax highlighting
au BufNewFile,BufRead *.json set ft=json syntax=javascript
