# dotFiles
My personal dot files. This repo includes scripts to help maintain the dotfiles between systems. In particular:
- update\_repo.sh will copy scripts from host machine to repo folder
- all\_diffs.sh will perform all diffs between repo files and files on local machine 

# Vim
Standard ~/.vimrc setup, downloads vim-plug on first setup. Extra file ~/.vim/plugins.vim listing all vim-plug plugins to install, credit to [this blog](https://medium.com/@huntie/10-essential-vim-plugins-for-2018-39957190b7a9) for the idea.

Run ':PlugInstall' on first setup.

# Bash
On mac, the .bashrc will be replaced by .bash\_profile. To allow one .bashrc between linux and mac add the following to your .bash\_profile
'''
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
'''
Then the .bashrc can be used on mac too, credit to [this blog](https://medium.com/@tzhenghao/a-guide-to-building-a-great-bashrc-23c52e466b1c).
