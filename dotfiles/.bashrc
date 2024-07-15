# envs
export XDG_CONFIG_HOME="$HOME"/.config

# dirs
export REPOS="$HOME/repos"
export GH_REPOS="$REPOS/github.com"
export DOTFILES="$GH_REPOS/dotfiles"

# ------ MacOS -----
# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# disable "default interactive shell is..." warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# key repeat
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1
# ------------------

# aliases
alias ..="cd .."
alias la="ls -la"

alias dots="cd $DOTFILES"
alias repos="cd $REPOS"
alias ghrepos="cd $GH_REPOS"

alias t="tmux"

