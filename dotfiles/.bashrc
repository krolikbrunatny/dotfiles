# envs
export XDG_CONFIG_HOME="$HOME"/.config
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

# aliases
alias ..="cd .."
alias la="ls -la"

alias dots="cd $DOTFILES"
alias repos="cd $REPOS"
alias ghrepos="cd $GH_REPOS"

alias v="nvim"

## work
alias wrk="cd $HOME/work"
