# envs
export XDG_CONFIG_HOME="$HOME"/.config
export REPOS="$HOME/repos"
export GH_REPOS="$REPOS/github.com"
export DOTFILES="$GH_REPOS/dotfiles"

# ------ PS1 ------
export PS1='\W$(__git_ps1 "(%s)") \$ '
# -----------------

# ------ MacOS -----
# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# disable "default interactive shell is..." warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# key repeat
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

# natural scrolling
defaults write -g com.apple.swipescrolldirection -boolean NO
# ------------------

# ------ Second brain -----
export SECOND_BRAIN="$GH_REPOS/notes"
alias sb="cd $SECOND_BRAIN"
alias sbw="cd $SECOND_BRAIN/work && v ."
# -------------------------

# ------ tmux -----
alias t="tmux"
alias tas="tmux attach-session"
# -----------------

# ----- nvm -------
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
# -----------------

# -----  gcloud sdk -------
[[ -r "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc" ]] && source "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc"
# -------------------------

# ----- k8s -----------
## bash completion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

alias k="kubectl"
alias ct="kubie ctx"
alias ns="kubie ns"

export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/work-config.yaml"
# ---------------------

# -------- python  ----------
function vac {
  source "$(pwd)/.venv/bin/activate"
}
# ---------------------------

# --------- rust ------------
[[ -r "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
# ---------------------------

# -------- golang ----------
mkdir -p $HOME/.go
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
# --------------------------

# aliases
alias ..="cd .."
alias la="ls -la"

alias dots="cd $DOTFILES"
alias repos="cd $REPOS"
alias ghrepos="cd $GH_REPOS"

alias v="nvim"
# pomodoro aliases
p() {
  case "$1" in
  s)
    pomodoro start
    ;;
  f)
    pomodoro finish
    ;;
  c)
    pomodoro cancel
    ;;
  b)
    pomodoro break
    ;;
  *)
    echo "Usage: p {s|d|c|b}"
    echo "  s - start: Begin a Pomodoro session."
    echo "  f - finish: Complete the current Pomodoro session."
    echo "  c - cancel: Cancel the current Pomodoro session."
    echo "  b - break: Start a break after a Pomodoro session."
    ;;
  esac
}

## work
alias wrk="cd $HOME/work"
alias awsl="$HOME/work/scripts/aws_login.sh"
if [ -d "$HOME/work/scripts/in-path" ]; then
  export PATH=$PATH:"$HOME/work/scripts/in-path"
fi
