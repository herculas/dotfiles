" =============================================================================
"                  automatic installation of vim-plug
" =============================================================================

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . data_dir .
              \'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" =============================================================================
"                 automatic installation of missing plugins
" =============================================================================

" Install vim-plug if not found

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" =============================================================================
"                       install plugins via vim-plug
" =============================================================================

call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'         " color schemes
Plug 'vim-airline/vim-airline'                  " status and tabline

call plug#end()

" =============================================================================
"                            color theme settings
" =============================================================================

syntax enable
set background=dark
colorscheme solarized

" =============================================================================
"                               editor settings
" =============================================================================

set nu				                            " line numbers
set ruler			                            " bottom info
set nobackup
set noswapfile
set autoindent                                  " automatic indent
set tabstop=4                                   " 4 spaces for tab
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set hlsearch                                    " searching highlight
set incsearch                                   " intelligent instant searching
set cc=120                                      " color column at 120
set clipboard=unnamed
set clipboard=unnamedplus
set cursorline                                  " current line highlight
set encoding=utf-8
set mouse=a                                     " allow mouse clicking
set relativenumber

" =============================================================================
"                       vim airline tabline and status
" =============================================================================

let g:airline#extensions#tabline#enabled = 1
