# ============================================
# ENVIRONMENT VARIABLES
# ============================================
export XDG_CONFIG_HOME="$HOME"/.config
export REPOS="$HOME/repos"
export GH_REPOS="$REPOS/github.com"
export DOTFILES="$GH_REPOS/dotfiles"
export DOTFILES_WORK="$GH_REPOS/dotfiles-work"
export SECOND_BRAIN="$GH_REPOS/notes"
typeset -U path PATH

# ============================================
# SECOND BRAIN
# ============================================
alias sb="cd $SECOND_BRAIN"

# ============================================
# TMUX
# ============================================
alias t="tmux"
alias tas="tmux attach-session"

# Attach each terminal window to the shared session, but never nest tmux in its panes.
if [[ -z "$TMUX" ]] && command -v tmux &> /dev/null; then
  tmux new-session -A -s tmax
fi

# ============================================
# OPENCODE
# ============================================
export OPENCODE_SCRATCH="$HOME/.opencode/scratch"
alias o="opencode ."
alias oe="opencode $OPENCODE_SCRATCH"
function op() {
  tmux split-window -h
  tmux split-window -v
  tmux select-pane -L
  opencode .
}

# ============================================
# KUBERNETES
# ============================================
alias k="kubectl"
alias ct="kubie ctx"
alias ns="kubie ns"

# ============================================
# PYTHON
# ============================================
function vac {
  source "$(pwd)/.venv/bin/activate"
}

# ============================================
# GOLANG
# ============================================
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

# ============================================
# ALIASES
# ============================================
alias ..="cd .."
alias la="ls -la"
function glm() {
  git log --author="$(git config user.name)"
}

alias dots="cd $DOTFILES"
alias repos="cd $REPOS"
alias ghrepos="cd $GH_REPOS"

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
source "$ZSH/oh-my-zsh.sh"

# ============================================
# ATUIN
# ============================================
# Replace the default history search with Atuin's searchable, synchronized history.
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi

# ============================================
# CUSTOM SCRIPTS
# ============================================
function prettify() {
  if [[ -z "$1" ]]; then
    echo "Usage: prettify <file>"
    return 1
  fi
  jq . "$1" > "$1.pretty" && mv "$1.pretty" "$1"
}
