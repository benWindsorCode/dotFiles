#!/bin/bash

if [ -f "~/.bashrc" ]; then
	diff .bashrc ~/.bashrc
fi

if [ -f "~/.vimrc" ]; then
	diff .vimrc ~/.vimrc
fi

if [ -f "~/.vim/plugins.vim" ]; then
	diff .vim/plugins.vim ~/.vim/plugins.vim
fi
