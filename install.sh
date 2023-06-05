#!/usr/bin/env bash

# setops
set -e

# check nix
# nix
command -v "nix" &>/dev/null || {
  printf "\nnix not found. Please install nix and try again. For more information check https://nixos.org/download.html#nix-install-macos\n\n"
  exit 1
}

command -v "darwin-rebuild" &>/dev/null || {
  printf "\nnix-darwin not found. Please install nix-darwin and try again. For more information check https://github.com/LnL7/nix-darwin#install\n\n"
  exit 1
}

clear

# chezmoi
command -v "chezmoi" &>/dev/null || {
  printf "\nInstalling and setting up chezmoi and your dotfiles\n"
  printf "===================================================\n"
  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply ${GITHUB_USERNAME:-rage28}
}

# rebuild darwin config
printf "\nRebuilding nix-darwin configuration\n"
printf "===================================\n"
darwin-rebuild switch
