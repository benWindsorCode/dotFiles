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

# Emacs/Spacemacs/Doom Emacs
## Spacemacs
Spacemacs and Doom Emacs run ontop of Emacs as an extra layer. To setup Spacemacs:
- Download Emacs (dont launch it yet)
```
(MAC, add --no-quareantine flag if issues starting) brew cask install emacs-plus --with-imagemagick
(UBUNTU/other linux) use your standard package manager
(Windows) https://www.gnu.org/software/emacs/download.html#nonfree
```
- (Optional) Install [source code pro font](https://github.com/adobe-fonts/source-code-pro)
- Clone the spacemacs repo into the emacs config directory
```
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
```
- Add the below custom code into the ~/.spacemacs

On windows a little more complex, just use WSL2 to avoid this (Note if you want to avoid %Appdata% update your HOME env var):
- Download Emacs
- Clone the spacemacs repo into the %Appdata% emacs config folder, .spacemacs will live in %Appdata%
## Doom Emacs
For Doom Emacs, follow the above to get emacs working (emacs-plus on mac) then:
- Clone doom emacs into your config directory and install
``` 
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
```
- Enable any extra packages you want in ~/.doom.d/init.el
- Install the packages by running
``` 
cd ~/.emacs.d/bin
./doom sync
```

### Projects and Magit
From here you can then select a project with 'SPC p p', and SPC SPC to search within that project. If you need project discovery to run use M-x projectile-discover-projects-in-search-path.

Magit from within the project accessed with SPC g g, then use s to stage files for commit, c c to commit, p u to push to master (use ? to see other commands here).

Fantastic detailed doom config here: https://github.com/sunnyhasija/Academic-Doom-Emacs-Config
Which detaisl the flow from these gifs for notating papers: https://www.reddit.com/r/emacs/comments/hltl69/org_roam_for_academics_demo/

See doom emacs packages here: https://github.com/hlissner/doom-emacs/blob/develop/docs/modules.org
## Customisation
You then need to make the following change to enable org-capture etc. gtd setup:
- Enable the org layer for spacemacs by uncommenting 'org' from the .spacemacs file/uncommenting org in ~/.doom.d/init.el
- Add the below snippet into your .spacemacs under the 'defun dotspacemacs/user-config' section, replacing paths to code folder as appropriate/in your ~/.doom.d/config.el
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
(If you are just using standard emacs, you can use the above snippet just remove the outer with-eval-after-load 'org piece.)
- For doom project management you may also want to add to your ~/.doom.d/config.el
```
(setq projectile-project-search-path '("~/Documents/code/"))
```
For daemon/server setup see: [link1](https://www.emacswiki.org/emacs/EmacsMsWindowsIntegration) and [link2](https://www.reddit.com/r/emacs/comments/1s9tfk/emacs_server_mode_on_windows/).

Roughly on windows the idea is to create a shortcut with a command like:
```
"C:\Program Files (x86)\emacs-26.3-x86_64\bin\emacsclientw.exe" -c -n -a runemacs.exe
```
which will hook into an existing frame if its already open.

# Org Mode (Doom Emacs)
SPC m q - insert tag ([useful video](https://www.youtube.com/watch?v=FJq__bBi0nI&ab_channel=ZaisteProgramming))

# Org Roam (Doom Emacs)
To visualise your graph (SPC n r g) you will need graphviz installed. 

On Mac for example use

```
brew install graphviz
```

You can jump back to a previous link with M-x org-mark-ring-goto.

SPC n r b - see org roam buffers
SPC n r r - activate org roam sidebar
SPC n r i - insert org roam link
SPC n r c - capture org roam in scratch buffer

# Git/Magit (Doom Emacs)
Doom emacs uses the magit plugin. Once inside a project with git enabled the rough flow is as follows:
- SPC g g to open magi
- select files for staging with s
- c c to commit
- p u to push to master

# Gtd
My getting things done setup is linked to Emacs and org-capture. There are three important pieces here:
1) Org capture to pull tasks into an inbox file
2) The gtd.org file for projects, the tickler.org file for dated items and someday.org for tasks one day
3) The org-agenda mode can then be used to view tasks as required. 

Source: [this blog](https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html)
