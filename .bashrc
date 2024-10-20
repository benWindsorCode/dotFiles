alias code='cd ~/Documents/code'
alias status='git status'
alias add='git add .'
alias commit='git commit -m'
alias push='git push'
alias pull='git pull'
alias master='git checkout master'

export PATH="$HOME/.config/emacs/bin":$PATH
export PATH="$HOME/.emacs.d/bin":$PATH
export PATH="$HOME/.doom.d/bin":$PATH

# On WSL2 makes org roam ui not complain
export BROWSER="powershell.exe /C start"

export EDITOR=vim
