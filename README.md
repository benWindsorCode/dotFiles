# dotFiles
My personal dot files. This repo includes scripts to help maintain the dotfiles between systems. In particular:
- update\_repo.sh will copy scripts from host machine to repo folder
- update\_local.sh will copy scripts from repo to host machine
- all\_diffs.sh will perform all diffs between repo files and files on local machine 

N.B.: The abvoe scripts are still WIP, run at your own risk! The dotfiles themselves are all good though.

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
On mac, .bash\_profile is used instead of .bashrc. To allow one .bashrc between linux and mac add the following to your .bash\_profile
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

# Emacs/Spacemacs
To setup Spacemacs on linux is easy:
- Download Emacs
- Clone the spacemacs repo into the emacs  config directory
- Add the below custom code into the ~/.spacemacs

On windows a little more complex (Note if you want to avoid %Appdata% update your HOME env var):
- Download Emacs
- Clone the spacemacs repo into the %Appdata% emacs config folder
- Add the below custom code into the .spacemacs folder in %Appdata%
- For any file paths keep unix style forward slashes

After setting up the above, add the above code into your .spacemacs under the 'defun dotspacemacs/user-config' section.
```
(with-eval-after-load 'org
  (setq org-directory "C:/Users/benja/Documents/code/orgFiles")

  (setq org-default-notes-file (concat org-directory "/gtd/inbox.org"))
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "C:/Users/benja/Documents/code/orgFiles/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "C:/Users/benja/Documents/code/orgFiles/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")))

  (setq org-refile-targets '(("C:/Users/benja/Documents/code/orgFiles/gtd/gtd.org" :maxlevel . 3)
                           ("C:/Users/benja/Documents/code/orgFiles/gtd/someday.org" :level . 1)
                           ("C:/Users/benja/Documents/code/orgFiles/gtd/tickler.org" :maxlevel . 2)))
)
```
If you are just using standard emacs, you can use the above snippet just remove the outer with-eval-after-load 'org piece.
