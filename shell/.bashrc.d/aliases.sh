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
alias tmux='tmux-start'
alias live-server='npx live-server'
# Alias docker-compose to it's plugin
# so we can bypass the podman wrapper
alias docker-compose='/usr/libexec/docker/cli-plugins/docker-compose'

# gh aliases
# if command -v gh &> /dev/null; then
#     gh alias set 'pr-main' 'pr create --base=main -fw'
#     gh alias set 'pr-master' 'pr create --base=master -fw'
# fi
