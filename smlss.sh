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

cd .. # go to home directory

# cut the "/home/" from the pwd to get the installer's username, since smlss is
# ran as root.
username=$(pwd | cut -c 7-)


# switch to unstable repositories
sed -i 's/buster main/sid main/' /etc/apt/sources.list
apt update
# download and install packages in packages.txt
for pkg in $(cat "/home/$username/smlss/packages.txt"); do
    apt -y install "$pkg"
done

# set up symlinks to config files
for item in $(ls -A1 "/home/$username/smlss/dotfiles")
do
    ln -sf "/home/$username/smlss/dotfiles/$item" "/home/$username/$item"
done

# links for nvim
mkdir "/home/$username/.config"
ln -s "/home/$username/smlss/dotfiles/nvim" "/home/$username/.config/nvim"

# install suckless programs (dwm, st, etc.)
for item in $(ls -A1 "/home/$username/smlss/suckless")
do
	cd "/home/$username/smlss/suckless/$item"
    make
	make install
done

# install rust (rustup)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |
	sh -s -- -y --no-modify-path # rust env-vars already in PATH, in .profile

# make pianobar fifo, for use in "scripts/toggle-music-pause.sh"
mkdir "/home/$username/.config/pianobar"
mkfifo "/home/$username/.config/pianobar/ctl"

# make the installing user the owner of all files created
cd "/home/$username"
shopt -s globstar
chown "$username" ** -Rh 
chown "$username" .** -Rh 
cd "/home/$username/smlss"

