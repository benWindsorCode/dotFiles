# Dot Files
My personal dot files. This repo includes scripts to help maintain the dotfiles between systems. In particular:
- dotfile_utils\\update\_repo.sh will copy scripts from host machine to repo folder
- dotfile_utils\\update\_local.sh will copy scripts from repo to host machine
- dotfile_utils\\diffs.sh will perform all diffs between repo files and files on local machine 

N.B.: The above scripts are still WIP, run at your own risk! The dotfiles themselves are all good though.

# Prerequisite Install List
To use the dotfiles install:
- ripgrep
- silversearcher-ag 
- ctags
- texlive (for org export)
- texlive-latex-extra (for org export)

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

# Ubuntu setup
Basic install list:
- gcc
- make
- emacs
- vim
- intellij/pycharm/etc.

Quality of life:
- install gnome tweaks and disable https://www.linuxuprising.com/2018/09/how-to-disable-mouse-acceleration-in.html
- for tiling windows install tiling-assistant https://github.com/Leleat/Tiling-Assistant
- zsh + oh my zsh + powerlevel10k
- piper (mouse mapping)

For mouse vol up/down:
- in ubuntu keyboard settings map volume up and volume down to ctrl+alt+up/down respectively
- in Piper map the two mouse buttons to these key sequences and they will then trigger vol up/down

# Emacs/Spacemacs/Doom Emacs
## Keybind Reminders
| Command | Emacs | Doom Emacs |
| -- | -- | -- |
| Save | C-x C-s | :q |
| Open | C-x C-f | SPC SPC |
| Split Window Below | C-x 2 | - |
| Focus On Other Window | C-x o | - |
| Org Capture | C-c c | SPC X |
| Org Agenda | C-c a | SPC o A |
| Org Schedule | C-c C-s | - |
| Org Tag | C-c C-c | - |
| Org Timestamp | C-c . | |
| Change Project | - | SPC p p |

Note: all normal emacs commands work in Doom Emacs as long as you are in Normal mode
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
- Install fonts with M-x nerd-icons-install-fonts (on windows then doubel click on the font file after it loads) 
### Doom Emacs Mac
- Install emacs first with 

``` shell
brew install emacs-plus
```
- Note: if you face issues with freezes when you open a file or run magit on mac its to do with gpg and you need to 

``` shell
brew install gnupg@2.2
```
Then update your /etc/paths file to add

``` shell
/usr/local/opt/gnupg@2.2/
~/.config/emacs/bin
```

### Projects 
- SPC p p = select a project
- SPC p a = add a new project
- SPC p i = refresh the project file cache
- SPC SPC = search within a project
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

# Org Latex Export
You need prerequisites

``` shell
sudo apt install texlive
sudo apt install texlive-latex-extra
```

# Org Mode (Doom Emacs)
SPC m q - insert tag ([useful video](https://www.youtube.com/watch?v=FJq__bBi0nI&ab_channel=ZaisteProgramming))
SPC m e - org export dispatch

# Org Roam (Doom Emacs)
SPC n r b - see org roam buffers
SPC n r r - activate org roam sidebar
SPC n r i - insert org roam link
SPC n r c - capture org roam in scratch buffer
You can jump back to a previous link with M-x org-mark-ring-goto.

Easiest way to see your graph is via org-roam-ui: https://github.com/org-roam/org-roam-ui
Once installed then run:

``` 
M-x org-roam-ui-mode
```
And go to http://127.0.0.1:35901/ for an interactive view of your graph.

Another option is to generate a graph via graphviz (SPC n r g) you will need graphviz installed. 

On Mac for example use

```
brew install graphviz
```

# Git/Magit (Doom Emacs)
Doom emacs uses the magit plugin. Once inside a project with git enabled the rough flow is as follows:
- SPC g g to open magi
- select files for staging with s
- c c to commit
- p u to push to master
- F p to pull from master

# Gtd
My getting things done setup is linked to Emacs and org-capture. There are three important pieces here:
1) Org capture to pull tasks into an inbox file
2) The gtd.org file for projects, the tickler.org file for dated items and someday.org for tasks one day
3) The org-agenda mode can then be used to view tasks as required. 

Good agenda examples: https://protesilaos.com/codelog/2021-12-09-emacs-org-block-agenda/

More agenda examples: https://blog.aaronbieber.com/2016/09/24/an-agenda-for-life-with-org-mode.html

Org mode for gtd: https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html
## Csv export
Note you can export to command line your org agenda with
```
emacs --batch -l ~/.doom.d/config.el --eval '(org-batch-agenda "a" org-agenda-span (quote month))'
```
or as a csv
```
emacs --batch -l ~/.doom.d/config.el --eval '(org-batch-agenda-csv "a" org-agenda-span (quote month))'
```
Source: [this blog](https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html)
## Html export
Youll need the htmlize package.

Html export is done via two pieces, firstly you must provide html file names per agenda mode: https://orgmode.org/manual/Exporting-Agenda-Views.html 

e.g.
```
  (setq org-agenda-custom-commands
        '(("n" agenda "" nil ("agenda.html"))))
```
If vanilla emacs then you can use emacs --batch --eval '(org-store-agenda-views), NOTE: youll need to either pass a '-l' emacs init file to identify your 'org-agenda-files' or you can set it in the cmd .

However if using doom emacs, you have another option, to create your own doomscript per this issue: https://github.com/doomemacs/doomemacs/issues/6494 and these examples https://gist.github.com/hlissner/ba8c3b4c6f37c24ff27b72194942b7aa

e.g. in ~/.doom.d/bin/export-org
```
#!/usr/bin/env doomscript

(defcli! export-org ()
        (require 'core-start)
        (org-store-agenda-views))

(run! "export-org" (cdr (member "--" argv)))
```
Then you need to 
```
chmod +x export-org
```
Then you can finally:
```
doomscript ~/.doom.d/bin/export-org
```
OR if you have the following in your ~/.bashrc 
```
export PATH="$HOME/.emacs.d/bin":$PATH
export PATH="$HOME/.doom.d/bin":$PATH
```
you can just run
```
export-org
```
## Errors of style '/usr/bin/env: ‘bash\r’: No such file or directory'
Error with windows/linux formatting of lines, fix using
``` 
dos2unix [filename]
```
https://stackoverflow.com/questions/18172405/getting-error-usr-bin-env-sh-no-such-file-or-directory-when-running-command-p

## Spacemacs (DEPRECATED for my setup)
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
