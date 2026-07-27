#!/usr/bin/env bash
# Setup the system, should be run at-least once

# Install required packages from OS package manager

set -e

PACKAGES="stow tmux direnv ripgrep"

# Install the packages if not already installed
if ! command -v tmux &> /dev/null
then
    echo "[.workshop]: Installing packages"
    if command -v dnf &> /dev/null
    then
        # Fedora
        sudo dnf install $PACKAGES
    elif command -v apt-get &> /dev/null
    then
        # Ubuntu
        sudo apt-get update
        sudo apt-get install $PACKAGES
    fi
fi

if ! command -v nvim &> /dev/null
then
    # Install Neovim
    mkdir -p ~/.local/bin
    curl -L https://github.com/neovim/neovim/releases/download/v0.12.4/nvim-linux-x86_64.tar.gz -o /tmp/nvim-linux-x86_64.tar.gz
    sudo rm -rf ~/.local/bin/nvim-linux-x86_64
    tar -C ~/.local/bin -xzf /tmp/nvim-linux-x86_64.tar.gz
    ln -s ~/.local/bin/nvim-linux-x86_64/bin/nvim ~/.local/bin/
fi
