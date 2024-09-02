# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
export LANG=en_GB.UTF-8

# Prompt
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
source "$HOME/.git-prompt.sh"
# Fedora default PS1:
# PS1='${PROMPT_START@P}\[\e[${PROMPT_COLOR}m\]${PROMPT_USERHOST@P}\[\e[0m\]${PROMPT_SEPARATOR@P}\[\e[${PROMPT_DIR_COLOR:-${PROMPT_COLOR}}m\]${PROMPT_DIRECTORY@P}\[\e[0m\]${PROMPT_END@P}\$\[\e[0m\]'
# Don't show the host as part of the user
PROMPT_USERHOST='\u'
# Show only current directory and, if we're in a git repo, the branch name
PROMPT_DIRECTORY='\W$(__git_ps1 " (%s)")'

# Bash-completion
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# Aliases
alias gp="git pull"
alias gs="git status"
alias gf="git fetch"
alias gd="git diff"
alias dock-up="docker compose up -d --remove-orphans"
alias dock-down="docker compose down"
alias dock-login='echo $GITHUB_TOKEN | docker login -u $GITHUB_USER --password-stdin ghcr.io'
alias listening-ports='lsof -i -P | grep -i "listen"'
alias poetry-outdated="poetry show --outdated | grep --file=<(poetry show --tree | grep '^\w' | cut -d' ' -f1)"

# GIT
export GIT_EDITOR=nvim

# Docker
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Rust
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# direnv
eval "$(direnv hook bash)"
