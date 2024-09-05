# .bash_profile
# Run on login, so expected to be run once.

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

# Update rust bash completions
if command -v rustup &> /dev/null; then
    mkdir -p $HOME/.local/share/bash-completion/completions
    rustup completions bash > $HOME/.local/share/bash-completion/completions/rustup
    rustup completions bash cargo > $HOME/.local/share/bash-completion/completions/cargo
fi

# Symlink asdf bash-completions
[[ -f "$HOME/.asdf/completions/asdf.bash" ]] && \
    [[ ! -f "$HOME/.local/share/bash-completion/completions/asdf" ]] && \
    ln -s "$HOME/.asdf/completions/asdf.bash" "$HOME/.local/share/bash-completion/completions/asdf"
