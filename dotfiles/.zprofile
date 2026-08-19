# ============================================
# LOGIN ENVIRONMENT
# ============================================
export XDG_CONFIG_HOME="$HOME/.config"
export REPOS="$HOME/repos"
export GH_REPOS="$REPOS/github.com"
export DOTFILES="$GH_REPOS/dotfiles"
export DOTFILES_WORK="$GH_REPOS/dotfiles-work"
export SECOND_BRAIN="$GH_REPOS/notes"
typeset -U path PATH

# Homebrew's environment only needs to be established once per terminal login.
if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# These only update PATH, so inherit them into every tmux pane from the login shell.
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

# Google Cloud SDK
if command -v brew >/dev/null 2>&1; then
  gcloud_path="$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
  [[ -r "$gcloud_path" ]] && source "$gcloud_path"
fi
