#!/bin/sh
# Copyright (c) 2019-2021 Sebastian LaVine <mail@smlavine.com>
# Licensed under the GNU GPLv3. See smlss/GPLv3.txt for details.

# The user may not download smlss to the place that it is ultimately supposed to
# be. We should move the directory to the path specified by $SMLSS_DIR in
# dots/bash/env_vars.
currentsmlss="$(realpath $(dirname "$0"))"
. "$currentsmlss/dots/bash/env_vars"
if [ "$currentsmlss" != "$(realpath -m "$SMLSS_DIR")" ]; then
	printf "Moving smlss/ to "$(realpath -m "$SMLSS_DIR")"..."
	mkdir -p "$(realpath -m $SMLSS_DIR)"
	mv -T "$currentsmlss" "$(realpath -m $SMLSS_DIR)"
	echo 'done.'
fi

# Give all users in group "wheel" sudo privileges; This is necessary for yay to
# install packages properly, and is desirable anyway.
echo "Modifying sudoers file. Enter your root password."
su -c 'sed -i "s/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/" /etc/sudoers'

# Install Yay AUR helper, but only if it isn't already installed.
which yay && echo 'Yay already installed, skipping.' ||
	(git clone https://aur.archlinux.org/yay.git &&
	cd "$HOME/yay" &&
	makepkg -si &&
	cd "$HOME" &&
	rm -rf "$HOME/yay")

# install Arch and AUR packages in packages.txt and aur-packages.txt
# explicitly NO QUOTES here, otherwise all packages will be read as one
echo "Installing packages. Enter your root password."
yay -Syu --needed --sudoloop $(cat $SMLSS_DIR/packages.txt $SMLSS_DIR/aur-packages.txt)

# set up symlinks to config files
mkdir  "$XDG_CONFIG_HOME"
ln -sfT "$SMLSS_DIR/dots/.bashrc"            "$HOME/.bashrc"
ln -sfT "$SMLSS_DIR/dots/bash"               "$XDG_CONFIG_HOME/bash"
ln -sfT "$SMLSS_DIR/dots/bash_completion"    "$BASH_COMPLETION_USER_FILE"
ln -sfT "$SMLSS_DIR/dots/.libao"             "$HOME/.libao"
ln -sfT "$SMLSS_DIR/dots/.profile"           "$HOME/.profile"
ln -sfT "$SMLSS_DIR/dots/.xinitrc"           "$HOME/.xinitrc"
ln -sfT "$SMLSS_DIR/dots/nvim"               "$XDG_CONFIG_HOME/nvim"
ln -sfT "$SMLSS_DIR/dots/streamlink"         "$XDG_CONFIG_HOME/streamlink"
ln -sfT "$SMLSS_DIR/dots/dircolors"          "$XDG_CONFIG_HOME/dircolors"
ln -sfT "$SMLSS_DIR/dots/default.pa"         "$XDG_CONFIG_HOME/pulse/default.pa"

# make pianobar fifo, for use in "scripts/toggle-music-pause.sh"
[ -d "$XDG_CONFIG_HOME/pianobar" ] || (mkdir "$XDG_CONFIG_HOME/pianobar" &&
	mkfifo "$XDG_CONFIG_HOME/pianobar/ctl")

# install suckless programs (dwm, st, etc.)
for item in $(ls -A1 "$SMLSS_DIR/suckless")
do
	cd "$SMLSS_DIR/suckless/$item"
    make install clean
done

# Remove files that were put in the home directory upon creation.
rm .bash_history
rm .bash_logout
rm .bash_profile

echo "smlss complete."
