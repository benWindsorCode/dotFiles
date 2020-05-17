# dotFiles
My personal dot files. This repo includes scripts to help maintain the dotfiles between systems. In particular:
- update\_repo.sh will copy scripts from host machine to repo folder
- update\_local.sh will copy scripts from repo to host machine
- all\_diffs.sh will perform all diffs between repo files and files on local machine 

# Prerequisite Install List
To use the dotfiles install:
- ripgrep
- silversearcher-ag 
- ctags

# Vim
Standard ~/.vimrc setup, downloads vim-plug on first setup. Extra file ~/.vim/plugins.vim listing all vim-plug plugins to install, credit to [this blog](https://medium.com/@huntie/10-essential-vim-plugins-for-2018-39957190b7a9) for the idea.

Run ':PlugInstall' on first setup.

Running 'vim' on its own will start vim IDE style env with nerd tree on left and tag list on right hand side. Running 'vim [filename]'  will open standard vim. 

Key Bindings:
- ctrl+shift+N = intellij style fuzzy file search (FZF plugin)
- ctrl+shift+F = intellij style search within files (ag plugin)
- ctrl+shift+O = vs code style file outline (tags plugin)

# Bash
On mac, the .bashrc will be replaced by .bash\_profile. To allow one .bashrc between linux and mac add the following to your .bash\_profile
```
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
```
Then the .bashrc can be used on mac too, credit to [this blog](https://medium.com/@tzhenghao/a-guide-to-building-a-great-bashrc-23c52e466b1c).

Extra Aliases:
- master = checkout master branch
- push = git push
- pull = git pull
- status = git status
- commit [message] = git -m commit [message]
- code = cd ~/Documents/code, takes me to my folder where I keep all my repos
