#!/usr/bin/env bash

# setops
set -e

# vars
declare -r DOTPWD=$(pwd -P)

clear

# chezmoi
command -v "chezmoi" &>/dev/null || {
  printf "Installing and setting up chezmoi and your dotfiles\n\n"
  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply ${GITHUB_USERNAME:-rage28}
}

# nix
command -v "nix" &>/dev/null || {
  printf "\n\nInstalling nix\n\n"
  curl -L https://nixos.org/nix/install | sh
}

# nix darwin
command -v "darwin-rebuild" &>/dev/null || {
  printf "\n\nInstalling nix-darwin\n\n"
  nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
  ./${DOTPWD}/result/bin/darwin-installer

  # update rc after nix-darwin to wait for /etc/static
  source /etc/bashrc 
  darwin-rebuild switch
}
