#!/bin/bash
# Copyright (c) 2019-2020 Sebastian LaVine <seblavine@outlook.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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

