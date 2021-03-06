set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" Avoid a name conflict with L9
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line




call pathogen#infect()

filetype on
filetype plugin indent on
filetype plugin on

set encoding=utf-8
"
" Display extra whitespace
"set fillchars+=stl:\ ,stlnc: 
set list listchars=tab:▸\ ,trail:·,eol:¬
set mps+=<:>
"
set autowrite
"
colorscheme molokai
"
set tabstop=4
set backspace=2
set backspace=indent,eol,start 
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
"
set showmatch
set smartcase
set smarttab
set showcmd
set incsearch
"
set confirm
set number
set laststatus=2
"
set timeout timeoutlen=500 ttimeoutlen=1
set autoread
"
set novisualbell
set visualbell t_vb=
set ruler
"
set cindent
set t_RV=
"
set title
set cursorcolumn
set cursorline
"
set lazyredraw
" set confirm
set viminfo='20,\"500
set hidden
set history=50
set clipboard=unnamedplus
"
set foldmethod=indent
set foldlevel=99
"
" Minimal number of screen lines to keep above and below the cursor
set scrolloff=10
"
" Instead of these two options, we can set a single directory for all backups
" and temporary buffers. This is a better solution in case we don't want our
" current buffer to be destroyed due to any IOError.
"
" set backupdir=~/.vimtmp
" set directory=~/.vimtmp
set nobackup
set nowritebackup " Writes the buffer to the same file
set noswapfile
"
" Don’t show the intro message when starting Vim
set shortmess=atI
"
" Optimize for fast terminal connections
set ttyfast

""" Custom mappings
"
let mapleader=','
set pastetoggle=<F2>
"
" Windows like movements for long lines with wrap enabled:
noremap j gj
noremap k gk
"
" Allow saving of files as sudo when I forget to start vim using sudo.
cmap w!! :w !sudo tee > /dev/null %
"
" Do not leave visual mode after visually shifting text
vnoremap < <gv
vnoremap > >gv

" Tab control
nmap <Leader>tt :tabnew<cr>
nmap <Leader>tn :tabnext<cr>
nmap <Leader>tp :tabprevious<cr>
nmap <Leader>tc :tabclose<cr>
"
""" Commands
"
" Set syntax if terminal supports colors
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    set t_Co=256
    syntax on
endif
"
augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=79

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Set spell for markdown files
  autocmd BufRead,BufNewFile *.md setlocal spell
augroup END
"
" Strip trailing whitespace (,ss)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
"
if exists("+spelllang")
  set spelllang=en_us
endif
set spellfile=~/.vim/spell/en.utf-8.add
"
if has('gui_running')
  set guifont=Droid\ Sans\ Mono\ 10
endif
"
"
au VimResized * :wincmd =
"
au FocusLost * silent! wa
"
set wildchar=<Tab> wildmenu wildmode=full
set complete=.,w,t
"
"set wildmenu
"set wildmode=list:longest
set wildignore+=.hg,.git,.svn " Version Controls"
set wildignore+=*.aux,*.out,*.toc "Latex Indermediate files"
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary Imgs"
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
set wildignore+=*.spl "Compiled speolling world list"
set wildignore+=*.sw? "Vim swap files"
set wildignore+=*.DS_Store "OSX SHIT"
set wildignore+=*.luac "Lua byte code"
set wildignore+=migrations "Django migrations"
set wildignore+=*.pyc "Python Object codes"
set wildignore+=*.orig "Merge resolution files"

""" Plugin specific settings
"
"" YouCompleteMe
" global configuration file for C like languages
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_filetype_blacklist = {
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'text' : 1,
      \ 'unite' : 1
      \}
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf = 0
let g:ycm_goto_buffer_command='vertical-split'
"
"" nerdTree
nnoremap <F9> :NERDTreeToggle<cr>
let NERDTreeIgnore=['\~$', '\.swp$', '\.git', '\.vim$', '\~$', '\.pyc$']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"
"
"" vim-airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
 if !exists('g:airline_symbols')
   let g:airline_symbols = {}
 endif
" fix strange characters in status bar error
let g:airline_symbols.space="\u3000"
"
set tags=./tags;/
"
"" To close the error window when using :bdelete command
" ( For syntastic plugin )
nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
cabbrev <silent> bd lclose\|bdelete
" force syntastic to use Python 3
let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_ruby_checkers = ['rubocop']
"
"" Theme
let g:molokai_original = 1
let g:rehash256 = 1
"
"" Settings for Vim-notes
let g:notes_title_sync = 'rename_file'
"
"" Settings for UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/bundle/vim-snippets/UltiSnips"
"
"" Unite (inspired from terryma's dotfiles)
let g:unite_kind_file_vertical_preview = 1
" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_rank'])
" Start in insert mode
let g:unite_enable_start_insert = 1
" Enable history yank source
let g:unite_source_history_yank_enable = 1
" Map space to the prefix for Unite
nnoremap [unite] <Nop>
nmap <space> [unite]
" Quick file search
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file_rec/async file/new<CR>
" Quick grep from cwd
nnoremap <silent> [unite]g :<C-u>Unite -buffer-name=grep grep:.<CR>
" Quick yank history
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>
" Set up some custom ignores
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ 'git5/.*/review/',
      \ 'tmp/',
      \ 'node_modules/',
      \ 'bower_components/',
      \ 'dist/',
      \ '.pyc',
      \ ], '\|'))
" Quick line
nnoremap <silent> [unite]l :<C-u>Unite -buffer-name=search_file line<CR>
" Quick commands
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=commands command<CR>
" Quick search buffers
nnoremap <silent> [unite]b :<C-u>Unite -quick-match buffer<CR>
