" Forget being compatible with good ol' vi
set nocompatible

" ---------
" NeoBundle
" ---------

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Plugins
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/unite.vim' "{{{
  let g:unite_data_directory='~/.vim-tmp/unite'
  let g:unite_source_rec_max_cache_files=5000
  let g:unite_source_file_mru_long_limit=5000
  let g:unite_prompt='» '

  " Enable  unite-source-history/yank
  let g:unite_source_history_yank_enable=1

  " Start in insert mode
  let g:unite_enable_start_insert=1

  " Use ag for search
  if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --nogroup --column'
    let g:unite_source_grep_recursive_opt=''
  endif

  " Use the fuzzy matcher
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  " Use the rank sorter
  call unite#filters#sorter_default#use(['sorter_rank'])
  call unite#custom#source('file_rec/async', 'ignore_pattern', '\.\%(png\|gif\|jpe\?g\|swf\|ttf\|eot\|woff\)$')
  call unite#custom#source('grep', 'ignore_pattern', '\.\%(png\|gif\|jpe\?g\|swf\|ttf\|eot\|woff\|log\)$')

  function! s:unite_settings()
    nmap <buffer> <ESC> <Plug>(unite_exit)
    imap <buffer> <C-j> <Plug>(unite_select_next_line)
    imap <buffer> <C-k> <Plug>(unite_select_previous_line)
  endfunction
  autocmd FileType unite call s:unite_settings()

  " Prefix key
  nnoremap [unite] <Nop>
  nmap <space> [unite]

  " Mappings
  nnoremap <silent> [unite]<space> :<C-u>Unite -buffer-name=mru file_mru<CR>
  nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async:!<CR>
  nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<CR>
  nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<CR>
  nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>
  nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -buffer-name=search grep:.<CR>
"}}}
NeoBundle 'Shougo/unite-outline' "{{{
  nnoremap <silent> [unite]o :<C-u>Unite -auto-resize -buffer-name=outline outline<CR>
"}}}
NeoBundle 'Shougo/unite-help' "{{{
  nnoremap <silent> [unite]h :<C-u>Unite -auto-resize -buffer-name=help help<CR>
"}}}
NeoBundle 'Shougo/vimfiler.vim' "{{{
  let g:vimfiler_as_default_explorer=1
"}}}

NeoBundle 'bling/vim-airline' "{{{
  let g:airline_left_sep=''
  let g:airline_right_sep=''
"}}}
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'justinmk/vim-sneak'
NeoBundle 'junegunn/vim-easy-align' "{{{
  vnoremap <silent> <Enter> :EasyAlign<Enter>
  vnoremap <silent> <Leader><Enter> :LiveEasyAlign<Enter>
"}}}

" Languages
NeoBundle 'othree/html5.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'tpope/vim-haml'
NeoBundle 'kchmck/vim-coffee-script'

" Frameworks
NeoBundle 'tpope/vim-rails'

" Source Control
NeoBundle 'tpope/vim-fugitive'

" tmux
NeoBundle 'benmills/vimux' "{{{
  nnoremap <leader>vl :VimuxRunLastCommand<CR>
  nnoremap <leader>vc :VimuxPromptCommand<CR>
  nnoremap <leader>vq :VimuxCloseRunner<CR>
"}}}

NeoBundle 'christoomey/vim-tmux-navigator'

" Color Schemes
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'junegunn/seoul256.vim'

" Installation check
NeoBundleCheck

" -------
" General
" -------

" Syntax highlight and file type detection
syntax enable
filetype plugin indent on

" Allow unsaved background buffers
set hidden

" Bigger command history
set history=1000

set hlsearch                      " Highlight searches
set incsearch                     " ... incrementally as they are typed
set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

" Relative line numbers
set relativenumber

" Invisible character symbols
set listchars=tab:▶\ ,eol:¬

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Vim's encoding
set encoding=utf-8

" Intuitive backspacing
set backspace=indent,eol,start

" Default whitespace for all files
set ts=2 sts=2 sw=2 expandtab

" Colorscheme
colorscheme Tomorrow-Night

" Always show status line
set laststatus=2

" Keycode sequence timeout (ms)
set ttimeoutlen=50

" Folds
set foldmethod=marker
set foldlevelstart=99

" --------
" Autocmds
" --------

augroup filetypes_general
  autocmd!

  " Disable autocommenting on o O
  autocmd FileType * setlocal formatoptions-=o

  " Enable spellchecking for text files
  autocmd FileType text setlocal spell spelllang=en,el

  " ... and commit logs
  autocmd FileType *commit* setlocal spell

  " Disable it for help files
  autocmd FileType help setlocal nospell

  " Some default whitespace settings
  autocmd FileType ruby,yaml      setlocal ts=2 sts=2 sw=2 et
  autocmd FileType eruby,html,css setlocal ts=4 sts=4 sw=4 et
  autocmd FileType python         setlocal ts=4 sts=4 sw=4 et
  autocmd FileType javascript     setlocal ts=2 sts=2 sw=2 et
  autocmd FileType coffee         setlocal ts=2 sts=2 sw=2 et
augroup END


function! CoffeScriptMappings()
  nnoremap <leader>cc :CoffeeCompile vert"<cr><C-w>h
  nnoremap <leader>cw :CoffeeCompile watch vert"<cr>
endfunction

augroup coffeescript_mappings
  autocmd!

  autocmd FileType coffee call CoffeScriptMappings()
augroup END

" --------
" Mappings
" --------

" Switch j/k with gj/gk to move on display lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Remap manual page key K to nothing
nnoremap K <Nop>
vnoremap K <Nop>

" Remap H and L to move to the first/last character of the line
nnoremap H ^
nnoremap L $
xnoremap H ^
xnoremap L $

" Move around windows with <C-hjkl>
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l

" <C-pn> should filter the command history like <Up>/<Down>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" <C-a> should move the cursor position to the start of the command-line
cnoremap <C-a> <Home>

" Y yanks to the end of the line instead of yy
noremap Y y$

" Yank and put to/from the "* register
vnoremap <leader>y "*y
nnoremap <leader>p :put *<CR>
nnoremap <leader>P :put! *<CR>

" Mute highlight until next search
nmap <silent> <leader>l :nohlsearch<CR>

" Toggle invisible character symbols
nmap <silent> <leader>h :set list!<CR>

" Map <leader>e to pen files in the same directory as the current file
cnoremap %% <C-r>=expand('%:h') . '/'<CR>
nmap <leader>e :edit %%

" Map <leader><leader> to switch to alternate file <C-^>
nmap <leader><leader> <C-^>

" --------
" Commands
" --------

" Extract visual selection
xnoremap <leader>r :ExtractVisualSelection <C-r>=expand('%:h') . '/'<CR>

command! -range -bar -nargs=1 -bang -complete=file ExtractVisualSelection :
      \ let s:starts_at=expand(<line1>) |
      \ let s:ends_at=expand(<line2>) |
      \ let s:dst=expand(<q-args>) |
      \ execute s:starts_at . ',' . s:ends_at . 'write<bang>' . s:dst |
      \ execute s:starts_at . ',' . s:ends_at . 'delete' |
      \ execute 'rightbelow vsplit' . s:dst |
      \ execute 'normal =G' |
      \ unlet s:starts_at |
      \ unlet s:ends_at |
      \ unlet s:dst


" :SudoWrite and :Rename borrowed from vim-eunuch
" https://github.com/tpope/vim-eunuch

" Use :SudoWrite to write a file using sudo
command! -bar SudoWrite :
      \ setlocal nomodified |
      \ silent exe 'write !sudo tee % >/dev/null' |
      \ let &modified=v:shell_error

" Use :Rename to rename a file
command! -bar -nargs=1 -bang -complete=file Rename :
      \ let s:src=expand('%:p') |
      \ let s:dst=expand(<q-args>) |
      \ if isdirectory(s:dst) |
      \   let s:dst .= '/' . fnamemodify(s:src, ':t') |
      \ endif |
      \ if <bang>1 && filereadable(s:dst) |
      \   exe 'keepalt saveas '.fnameescape(s:dst) |
      \ elseif rename(s:src, s:dst) |
      \   echoerr 'Failed to rename "'.s:src.'" to "'.s:dst.'"' |
      \ else |
      \   setlocal modified |
      \   exe 'keepalt saveas! '.fnameescape(s:dst) |
      \   if s:src !=# expand('%:p') |
      \     execute 'bwipe '.fnameescape(s:src) |
      \   endif |
      \ endif |
      \ unlet s:src |
      \ unlet s:dst

" ---
" GUI
" ---

if has("gui_macvim")
  set guifont=Menlo:h11 " Change font

  " Default dimensions for a new window
  set lines=80 columns=120

  " GUI customization
  set go-=T " Remove toolbar
  " Remove vertical scrolling from both sides
  set guioptions-=r
  set guioptions-=L
endif
