# setup.sh
#
# Run by /etc/.bashrc on every new shell

export LANG=en_GB.UTF-8

# Prompt
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
source "$HOME/.git-prompt.sh"
# Tmux default PS1:
PS1='${PROMPT_START@P}\[\e[${PROMPT_COLOR}m\]${PROMPT_USERHOST@P}\[\e[0m\]${PROMPT_SEPARATOR@P}\[\e[${PROMPT_DIR_COLOR:-${PROMPT_COLOR}}m\] ${PROMPT_DIRECTORY@P}\[\e[0m\]${PROMPT_END@P}\$ \[\e[0m\]'
# Inject start escape sequence so tmux can find it
# With this we can scroll back/forward when in search using [p]revious and [n]ext
PROMPT_START='\[\e]133;A\e\\\]'
# Add colour, also for non-tmux shell
PROMPT_COLOR=32
# Don't show the host as part of the user
PROMPT_USERHOST='\u'
# Show only current directory and, if we're in a git repo, the branch name
PROMPT_DIRECTORY='\W$(__git_ps1 " (%s)")'

# Bash-completion
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# Editors
export EDITOR=nvim
export GIT_EDITOR=nvim

# Docker
# Point docker to the rootless podman socket
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Rust
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# ASDF
if ! [[ "$PATH" =~ "${ASDF_DATA_DIR:-$HOME/.asdf}/shims:" ]]; then
    export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fi

# direnv
eval "$(direnv hook bash)"

# homebrew
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
test -d $PYENV_ROOT/bin && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
