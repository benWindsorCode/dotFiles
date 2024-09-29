#!/bin/bash

if [[ -f "~/.bashrc" ]] 
then
	echo "Updating .bashrc"
	cp .bashrc ~/.bashrc
else
	echo "Creating .bashrc"
	cp .bashrc ~/
fi
	
if [[ -f "~/.vimrc" ]] 
then
	echo "Updating .vimrc"
	cp .vimrc ~/.vimrc
else
	echo "Creating .vimrc"
	cp .vimrc ~/
fi

if [[ -f "~/.vim/plugins.vim" ]] 
then
	echo "Updating .vim/plugins.vim"
	cp .vim/plugins.vim ~/.vim/plugins.vim
else
	echo "Creating .vim/ and .vim/plugins.vim"
	mkdir ~/.vim
	cp .vim/plugins.vim ~/.vim/plugins.vim
fi

