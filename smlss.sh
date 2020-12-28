#!/bin/bash
# Copyright (c) 2019-2020 Sebastian LaVine <mail@smlavine.com>
# Licensed under the GNU GPLv3. See smlss/GPLv3.txt for details.

# The user may not download smlss to the place that it is ultimately supposed to
# be. We should move the directory to the path specified by $SMLSS_DIR in
# dots/bash/env_vars.
currentsmlss="$(realpath $(dirname "$0"))"
. "$currentsmlss/dots/bash/env_vars"
#if [ "$currentsmlss" != "$(realpath -m "$SMLSS_DIR")" ]; then
#	printf "Moving smlss/ to $(realpath -m "$SMLSS_DIR")..."
#	mkdir -p "$(realpath -m $SMLSS_DIR)"
#	mv "$currentsmlss" "$(realpath -m $SMLSS_DIR)"
#	echo 'done.'
#fi

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
# explicitly NO QUOTES here: they prevent the brace expansion from working
echo "Installing packages. Enter your root password."
cat $SMLSS_DIR/{aur-,}packages.txt | xargs yay -Syu --needed

# set up symlinks to config files
mkdir  "$HOME/.config"
ln -sfT "$SMLSS_DIR/dots/.bashrc"       "$HOME/.bashrc"
ln -sfT "$SMLSS_DIR/dots/bash"          "$HOME/.config/bash"
ln -sfT "$SMLSS_DIR/dots/.libao"        "$HOME/.libao"
ln -sfT "$SMLSS_DIR/dots/.profile"      "$HOME/.profile"
ln -sfT "$SMLSS_DIR/dots/.xinitrc"      "$HOME/.xinitrc"
ln -sfT "$SMLSS_DIR/dots/nvim"          "$HOME/.config/nvim"
ln -sfT "$SMLSS_DIR/dots/streamlink"    "$HOME/.config/streamlink"
ln -sfT "$SMLSS_DIR/dots/dircolors"     "$HOME/.config/dircolors"
ln -sfT "$SMLSS_DIR/dots/default.pa"    "$HOME/.config/pulse/default.pa"

# make pianobar fifo, for use in "scripts/toggle-music-pause.sh"
[ -d "$HOME/.config/pianobar" ] || (mkdir "$HOME/.config/pianobar" &&
	mkfifo "$HOME/.config/pianobar/ctl")

# install suckless programs (dwm, st, etc.)
for item in $(ls -A1 "$SMLSS_DIR/suckless")
do
	cd "$SMLSS_DIR/suckless/$item"
    make install clean
done

echo "smlss complete."
