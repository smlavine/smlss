# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
fi

# Display neofetch on user login. I think it looks cool, okay?
neofetch

# Run startx only if a dwm process is not already running. This allows the user
# to open a text terminal in another tty.
[ "$(ps -a | grep dwm)" ] && echo "dwm already running" || startx

