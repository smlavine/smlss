#!/bin/bash
# Copyright (c) 2019-2020 Sebastian LaVine <mail@smlavine.com>
# Licensed under the GNU GPLv3. See smlss/GPLv3.txt for details.

cd "$HOME"

# give all users in group "wheel" sudo privileges; necessary for yay to install
# packages properly
echo "Modifying sudoers file. Enter your root password."
su -c 'sed -i "s/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/" /etc/sudoers'

# Install Yay AUR helper, but only if it isn't already installed.
which yay && echo 'Yay already installed, skipping.' ||
	git clone https://aur.archlinux.org/yay.git &&
	cd "$HOME/yay" &&
	makepkg -si &&
	cd "$HOME" &&
	rm -rf "$HOME/yay"

# install Arch and AUR packages in packages.txt and aur-packages.txt
# explicitly NO QUOTES here: they prevent the brace expansion from working
cat $HOME/smlss/{aur-,}packages.txt | xargs yay -Syu --needed

# set up symlinks to config files
mkdir  "$HOME/.config"
ln -sf "$HOME/smlss/dotfiles/.bashrc"       "$HOME/.bashrc"
ln -sf "$HOME/smlss/dotfiles/bash"          "$HOME/.config/bash"
ln -sf "$HOME/smlss/dotfiles/.libao"        "$HOME/.libao"
ln -sf "$HOME/smlss/dotfiles/.profile"      "$HOME/.profile"
ln -sf "$HOME/smlss/dotfiles/.xinitrc"      "$HOME/.xinitrc"
ln -sf "$HOME/smlss/dotfiles/nvim"          "$HOME/.config/nvim"
ln -sf "$HOME/smlss/dotfiles/streamlink"    "$HOME/.config/streamlink"
ln -sf "$HOME/smlss/dotfiles/dircolors"     "$HOME/.config/dircolors"
ln -sf "$HOME/smlss/dotfiles/default.pa"    "$HOME/.config/pulse/default.pa"

# make pianobar fifo, for use in "scripts/toggle-music-pause.sh"
[ -d "$HOME/.config/pianobar" ] || (mkdir "$HOME/.config/pianobar" &&
	mkfifo "$HOME/.config/pianobar/ctl")

# install suckless programs (dwm, st, etc.)
for item in $(ls -A1 "$HOME/smlss/suckless")
do
	cd "$HOME/smlss/suckless/$item"
    make install clean
done

# make the installing user the owner of all files created
cd "$HOME"
shopt -s globstar
chown "$USER" ** -Rh 
chown "$USER" .** -Rh 

