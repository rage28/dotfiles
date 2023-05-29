#!/usr/bin/env bash

builtin command -v "nix" &>/dev/null || {
  curl -L https://nixos.org/nix/install | sh
}

__nix_sync_packages() {
  packages=(
    nixpkgs.zsh
    nixpkgs.starship
    nixpkgs.chezmoi
  )

  nix-env -iA ${packages[@]}
}

builtin alias nixsync=__nix_sync_packages

# sync packages
nixsync
