# envs
export XDG_CONFIG_HOME="$HOME"/.config

# dirs
export REPOS="$HOME/repos"
export GH_REPOS="$REPOS/github.com"
export DOTFILES="$GH_REPOS/dotfiles"

# get rid of mail notifications on MacOS
unset MAILCHECK

# aliases
alias ..="cd .."

alias dots="cd $DOTFILES"
alias repos="cd $REPOS"
alias ghrepos="cd $GH_REPOS"

