# dotfiles

Personal macOS configuration. This repository owns shared terminal, shell, window-management, and personal application setup.

Work-specific configuration lives in the sibling `dotfiles-work` repository and is optional.
Clone both repositories and the notes repository under `$HOME/repos/github.com` to use the provided navigation aliases and optional work overlay.

## Setup

Install Apple's Command Line Tools, then clone the repository at the path expected by the shell aliases:

```sh
xcode-select --install
mkdir -p "$HOME/repos/github.com"
git clone https://github.com/krolikbrunatny/dotfiles.git "$HOME/repos/github.com/dotfiles"
cd "$HOME/repos/github.com/dotfiles"
```

The Command Line Tools installation opens a macOS dialog and must finish before `git clone` can run. Then apply the complete personal setup:

```sh
./apply.sh
```

It installs Homebrew, packages from `Brewfile`, Google Cloud CLI, Oh My Zsh, and the Hasklig system font when missing; creates configuration links; applies macOS preferences; and configures AeroSpace to start at login. Existing Homebrew packages are not upgraded. The script requires an internet connection and may request administrator privileges for Homebrew.

Google Cloud CLI is installed last because its Homebrew post-install step creates a Python virtual environment and can take several minutes without producing output. If that step fails, the rest of setup remains complete and the script prints a command to retry it.

The shell configuration initializes Homebrew, Google Cloud SDK, and Atuin history search at login. Go uses `$HOME/.go` as `GOPATH`. Atuin keeps history locally and shares it across terminal sessions on this Mac. Press `Ctrl-R` to search it.

## First Run

macOS and third-party services require these user-authorized steps after the script finishes:

1. Grant AeroSpace access in **System Settings > Privacy & Security > Accessibility** when prompted.
2. Open Ghostty once so macOS can complete its first-launch checks.
3. Sign in to applications such as Figma, Handy, Obsidian, Signal, Spotify, and Zed as needed.
4. Run `gcloud init` and `gh auth login` when those CLIs need authentication.

The `docker` package provides only the Docker CLI. Configure a remote Docker context or install an approved local container runtime before using Docker or kind.

## Work Overlay

Clone `dotfiles-work` beside this repository to enable its optional shell overlay. Its packages are intentionally separate from personal setup:

```sh
brew bundle --file ../dotfiles-work/Brewfile
```

Company tooling manages AWS profiles and Kubernetes configuration. Do not add their generated files, tokens, certificates, or credentials to either repository.

## Updates

Review installed-package drift before changing `Brewfile`. Run `brew bundle` only after deliberately updating the manifest.
