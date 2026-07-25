# Setup the system, should be run at-least once

# Install required packages from OS package manager
echo "[.workshop]: Installing packages"

PACKAGES="stow tmux neovim direnv"

if command -v dnf &> /dev/null
then
    # Fedora
    sudo dnf install $PACKAGES
elif command -v apt-get &> /dev/null
then
    # Ubuntu
    sudo apt-get install $PACKAGES
fi

