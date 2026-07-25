# Install all the symlinks to the configs in this repo
stow:
	stow --verbose=2 --target "$(HOME)" nvim tmux shell git editor fonts

# Install a .bashrc that ties into the rest of the configs
bashrc:
	stow --verbose=2 --target "$(HOME)" bash

# Install all configs, includeing .bashrc
full: stow bashrc

# Install the needed packages
install:
	./setup.sh

# Mark all recipes phony so they don't check their target file and always run
.PHONY: *
