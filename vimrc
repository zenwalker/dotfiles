filetype off

set nocompatible
set nobackup
set noswapfile
set noeb vb t_vb=           " disable error beeping
set tildeop                 " use ~ as operator for text objects like `~iw`
set nowrap                  " hate wrapping for tiny windows. It makes code absolute unreadable
set number                  " Show line numbers
set nostartofline           " Don’t reset cursor to start of line when moving around.
set colorcolumn=80          " bad and extrabad line sizes
set noshowmode              " Hide the current mode
set backspace=2             " use c-w and c+u
set showcmd                 " Display incomplete commands.
set scrolloff=8             " Start scrolling when we're 8 lines away from margins
set wildmode=full

:au InsertEnter * set cul   " Show cursor line in insert mode
:au InsertLeave * set nocul " Hide cursor line in insert mode


" # Automatically clean trailing whitespaces on save
  fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
  endfun

  autocmd BufWritePre *.* :call <SID>StripTrailingWhitespaces()

" # Encoding
  set encoding=utf-8 nobomb
  set fileencoding=utf-8 " Use UTF-8 without BOM

" # Search
  set incsearch
  set ignorecase " Ignore case of searches
  set hlsearch   " Highlight searches

" # Ident
  set tabstop=2
  set shiftwidth=2
  set smarttab
  set expandtab
  set autoindent
  set smartindent
  set list              " show invisibles
  set pastetoggle=<F2>  " to fix weird behawiour on paste, etc
  set lcs=tab:▸\        " Use the same symbols as TextMate for tabstops and EOLs

" # Plugins
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  Plugin 'ervandew/supertab'
  Plugin 'gmarik/Vundle.vim'

  Plugin 'mattn/emmet-vim'
    let g:user_emmet_install_global = 0
    autocmd FileType html,css EmmetInstall

  Plugin 'digitaltoad/vim-jade'
  Plugin 'juanedi/predawn.vim'

  Plugin 'plasticboy/vim-markdown'
    let g:vim_markdown_folding_disabled=1

  Plugin 'wavded/vim-stylus'

  Plugin 'gorodinskiy/vim-coloresque'
    au BufRead *.json set filetype=json " fix json mistype
    au BufRead,BufNewFile *.es6 set filetype=javascript

  Plugin 'bling/vim-airline'
    set laststatus=2                                  " vim-airline doesn't appear until I create a new split
    let g:airline_theme='lucius'                      " Colorscheme for airline
    let g:airline_left_sep = ''                       " Set custom left separator
    let g:airline_right_sep = ''                      " Set custom right separator
    let g:airline#extensions#tabline#enabled = 1      " Enable airline for tab-bar
    let g:airline#extensions#tabline#show_buffers = 1 " Don't display buffers in tab-bar with single tab
    let g:airline#extensions#tabline#fnamemod = ':t'  " Display only filename in tab
    let g:airline_section_y = ''                      " Don't display encoding

  Plugin 'editorconfig/editorconfig-vim'

  Plugin 'scrooloose/nerdtree'
    map <C-n> :NERDTreeToggle<CR>

  call vundle#end()
  filetype plugin indent on

if !has('gui_running')
  set t_Co=256
  let g:solarized_termcolors=256
endif

syntax enable
set background=dark
colorscheme predawn

" trasparent background
hi Normal ctermbg=none
