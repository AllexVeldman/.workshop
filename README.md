# .workshop
Contains all configurations to setup my preferred work environment, my "workshop".

## Setup
Run `make install` to install the needed packages.

Run `make` to symlink all configurations into `~/`.

If you also want to use the included `.bashrc`, run `make full` instead.

## How it works
When `make` is run, the configuration files are symlinked into `$HOME`.

For bash a `.bash_profile` is included that sets up auto-completions for login-shells.
Any new (non-login) shell sources `.bashrc`, which sources `.sourceme`.

When the `.bashrc` is not used, make sure to source `.sourceme` for new shells.

