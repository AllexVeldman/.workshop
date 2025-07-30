# .bash_profile
# Run on login, so expected to be run once.

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

# Update rust bash completions
mkdir -p $HOME/.local/share/bash-completion/completions
if command -v rustup &> /dev/null; then
    rustup completions bash > $HOME/.local/share/bash-completion/completions/rustup
    rustup completions bash cargo > $HOME/.local/share/bash-completion/completions/cargo
fi

# ASDF
if command -v asdf &> /dev/null; then
    asdf completion bash > "$HOME/.local/share/bash-completion/completions/asdf"
fi

# Update poetry completions
if command -v poetry &> /dev/null; then
    poetry completions bash > "$HOME/.local/share/bash-completion/completions/poetry"
fi

# kubectl
if command -v kubectl &> /dev/null; then
    kubectl completion bash > $HOME/.local/share/bash-completion/completions/kubectl
fi

# Docker
if command -v docker &> /dev/null; then
    docker completion bash > $HOME/.local/share/bash-completion/completions/docker
fi

# Just
# The Just completions for bash don't work the same way as the above
# When installed using brew the completions are automatically added correctly.

# homebrew
if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi
