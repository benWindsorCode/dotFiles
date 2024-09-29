#!/bin/sh

if [ -f "~/.bashrc" ]; then
	cp ~/.bashrc .bashrc
fi
	
if [ -f "~/.vimrc" ]; then
	cp ~/.vimrc .vimrc
fi

if [ -f "~/.vim/plugins.vim" ]; then
	cp ~/.vim/plugins.vim .vim/plugins.vim
fi
