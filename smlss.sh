#!/bin/bash
# Copyright (c) 2019-2020 Sebastian LaVine <seblavine@outlook.com>
# Licensed under the MIT license. See LICENSE for details.

cd "$HOME"

# install Arch packages in packages.txt
echo "Installing packages. Enter your root password."
su
xargs -a "$HOME/smlss/packages.txt" pacman -Syu
exit

# install Yay AUR helper
git clone https://aur.archlinux.org/yay.git
cd "$HOME/yay"
makepkg -si
cd "$HOME"
rm -r "$HOME/yay"

# install AUR packages in aur-packages.txt
xargs -a "$HOME/smlss/aur-packages.txt" yay -Syu

# set up symlinks to config files
mkdir  "$HOME/.config"
ln -sf "$HOME/smlss/dotfiles/.bash_aliases" "$HOME/.bash_aliases"
ln -sf "$HOME/smlss/dotfiles/.bash_logout"  "$HOME/.bash_logout"
ln -sf "$HOME/smlss/dotfiles/.bashrc"       "$HOME/.bashrc"
ln -sf "$HOME/smlss/dotfiles/.libao"        "$HOME/.libao"
ln -sf "$HOME/smlss/dotfiles/.profile"      "$HOME/.profile"
ln -sf "$HOME/smlss/dotfiles/.xinitrc"      "$HOME/.xinitrc"
ln -sf "$HOME/smlss/dotfiles/nvim"          "$HOME/.config/nvim"
ln -sf "$HOME/smlss/dotfiles/dircolors"     "$HOME/.config/dircolors"

# make pianobar fifo, for use in "scripts/toggle-music-pause.sh"
mkdir  "$HOME/.config/pianobar"
mkfifo "$HOME/.config/pianobar/ctl"

# install suckless programs (dwm, st, etc.)
for item in $(ls -A1 "$HOME/smlss/suckless")
do
	cd "$HOME/smlss/suckless/$item"
    make install clean
done

# install rust (rustup)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |
	sh -s -- -y --no-modify-path # rust env-vars already in PATH, in .profile


# make the installing user the owner of all files created
cd "$HOME"
shopt -s globstar
chown "$USER" ** -Rh 
chown "$USER" .** -Rh 

