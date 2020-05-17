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

" Ripgrep + FZF for fuzzy searching within files https://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before-2/
" I removed the --no-ignore
" Command for this is :RipgrepFzf, which I bind ctrl+shift+F per intellij
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf,scss}"
  \ -g "!*.{min.js,swp,o,zip}"
  \ -g "!{.git,node_modules,vendor}/*" '
command! -bang -nargs=* RipgrepFzf call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)


" List all plugins in the plugins.vim file
" RUN :PlugInstall to install them all
so ~/.vim/plugins.vim

" Enable line numbers
set number

" Enable indenting per file type
set autoindent
filetype plugin indent on
set shiftwidth=2
set tabstop=2

" Double the command and search patterns history
set history=100

" Enable syntax highlighting
syntax on
set background=dark
colorscheme solarized

" No beeping, blink instead
" set visualbell

" Move up and down editor lines
nnoremap j gj
nnoremap k gk

" Intellij style ctrl+shift+N and ctrl+shift+f to enter fuzzy searches
" VSCode outline ctrl+shift+O for tag list
nnoremap <C-S-n> :FZF<Enter>
nnoremap <C-S-o> :Tlist<Enter>
inoremap <C-s-n> <Esc>:FZF<Enter>
nnoremap <C-s-f> :RipgrepFzf<Enter>
inoremap <C-s-f> <Esc>:RipgrepFzf<Enter>

" status bar
set laststatus=2

" :FZF fuzzy search respects .gitignore N.B. requires  install of
" silversearcher-ag
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Tag list appears on right hand side
let Tlist_Use_Right_Window = 1

" open nerdtree if vim called with no args, put focus on editor
autocmd VimEnter * if !argc() | NERDTree | Tlist | wincmd w | endif
autocmd FileType java setlocal shiftwidth=4 tabstop=4
