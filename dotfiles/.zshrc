# envs
export XDG_CONFIG_HOME="$HOME"/.config
export REPOS="$HOME/repos"
export GH_REPOS="$REPOS/github.com"
export DOTFILES="$GH_REPOS/dotfiles"
export DOTFILES_WORK="$GH_REPOS/dotfiles-work"

# ------ PS1 ------
# export PS1='\W$(__git_ps1 "(%s)") \$ '
# -----------------

# ------ MacOS -----
# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# key repeat
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

# natural scrolling
defaults write -g com.apple.swipescrolldirection -boolean NO
# ------------------

# ------ Second brain -----
export SECOND_BRAIN="$GH_REPOS/notes"
alias sb="cd $SECOND_BRAIN"
# -------------------------

# ------ tmux -----
alias t="tmux"
alias tas="tmux attach-session"
# -----------------

# ----- nvm -------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

# ------ java :( --------
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# -----------------------

# aliases
alias ..="cd .."
alias la="ls -la"

alias dots="cd $DOTFILES"
alias repos="cd $REPOS"
alias ghrepos="cd $GH_REPOS"

alias v="nvim"

# work
if [[ -f "$DOTFILES_WORK/dotfiles/.zshrc" ]]; then
  source "$DOTFILES_WORK/dotfiles/.zshrc"
fi

# oh my zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
