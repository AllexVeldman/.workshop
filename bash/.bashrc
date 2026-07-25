# Run on new shells (non-login)

# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Source personal definitions
if [ -f ~/.sourceme ]; then
    source ~/.sourceme
fi
