# ============================================
# ENVIRONMENT VARIABLES
# ============================================
export XDG_CONFIG_HOME="$HOME"/.config
export REPOS="$HOME/repos"
export GH_REPOS="$REPOS/github.com"
export DOTFILES="$GH_REPOS/dotfiles"
export DOTFILES_WORK="$GH_REPOS/dotfiles-work"

# ============================================
# MACOS CONFIGURATION
# ============================================
# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Key repeat settings
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

# Natural scrolling
defaults write -g com.apple.swipescrolldirection -boolean NO

# ============================================
# SECOND BRAIN
# ============================================
export SECOND_BRAIN="$GH_REPOS/notes"
alias sb="cd $SECOND_BRAIN"

# ============================================
# TMUX
# ============================================
alias t="tmux"
alias tas="tmux attach-session"

# ============================================
# NODE VERSION MANAGER
# ============================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ============================================
# GOOGLE CLOUD SDK
# ============================================
[[ -r "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc" ]] && source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"

# ============================================
# KUBERNETES
# ============================================
alias k="kubectl"
alias ct="kubie ctx"
alias ns="kubie ns"

export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/work-config.yaml"

# ============================================
# PYTHON
# ============================================
function vac {
  source "$(pwd)/.venv/bin/activate"
}

# ============================================
# RUST
# ============================================
[[ -r "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# ============================================
# GOLANG
# ============================================
mkdir -p $HOME/.go
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# ============================================
# JAVA
# ============================================
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# ============================================
# ALIASES
# ============================================
alias ..="cd .."
alias la="ls -la"
alias glm="git log --author=\"$(git config user.name)\""

alias dots="cd $DOTFILES"
alias repos="cd $REPOS"
alias ghrepos="cd $GH_REPOS"

alias v="nvim"

# ============================================
# WORK CONFIGURATION
# ============================================
if [[ -f "$DOTFILES_WORK/dotfiles/.zshrc" ]]; then
  source "$DOTFILES_WORK/dotfiles/.zshrc"
fi

# ============================================
# OH MY ZSH
# ============================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ============================================
# CUSTOM SCRIPTS
# ============================================
function prettify() {
  if [ -z "$1" ]; then
    echo "Usage: prettify <file>"
    return 1
  fi
  jq . "$1" > "$1.pretty" && mv "$1.pretty" "$1"
}
