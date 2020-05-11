" Dont try to be vi compatible
set nocompatible

" Off to force plugings to load correctly when turned back on below
filetype off

" Install vim-plug on first run
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" List all plugins in the plugins.vim file
" RUN :PlugInstall to install them all
so ~/.vim/plugins.vim

" Enable line numbers
set number

" Enable indenting per file type
set autoindent
filetype plugin indent on

" Double the command and search patterns history
set history=100

" Enable syntax highlighting
syntax on

" No beeping, blink instead
" set visualbell

" Move up and down editor lines
nnoremap j gj
nnoremap k gk

" status bar
set laststatus=2
