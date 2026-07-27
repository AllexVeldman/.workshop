# Setup the system, should be run at-least once

# Install required packages from OS package manager
echo "[.workshop]: Installing packages"

PACKAGES="stow tmux direnv ripgrep"

if command -v dnf &> /dev/null
then
    # Fedora
    sudo dnf install $PACKAGES
elif command -v apt-get &> /dev/null
then
    # Ubuntu
    sudo apt-get install $PACKAGES
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
