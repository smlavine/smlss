# Copyright

Copyright (C) 2019-2020 Sebastian LaVine <mail@smlavine.com>

Copying and distribution of this file, with or without modification,
are permitted in any medium without royalty provided the copyright
notice and this notice regarding copyright of various aspects of smlss are
preserved. This file is offered as-is, without any warranty.

smlss.sh and the files in the dotfiles/ directory are licensed under the MIT
license (located in the LICENSE file). Files in the scripts/ directory are
individually licensed under either the MIT license or under the GPLv3, and you
should see the copyright notice at the head of each file if such details would
concern you or your usage of them.

The files scripts/extract and scripts/dmenurecord were originally written by
[Luke Smith](lukesmith.xyz), and are licensed under the
[GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.html).

See the LICENSE files in the directories of the suckless programs (located in
the suckless/ directory) for their copyright information.

# About

This is the script used to setup my Arch Linux system. Feel free to edit
it to your wants and needs. smlss is meant for users who use the terminal
frequently, program for leisure, and prefer tiling WMs. If you're one of
those people, great! If not, smlss may not be the best fit, but you're welcome
to try it out.


## OLD-HISTORY

I first began smlss in February of 2019, primarily inspired by Luke Smith's
[LARBS](https://larbs.xyz) project. I knew almost nothing about Git, or how to
use it, and so I used it poorly. In particular, I made the mistake of putting
several large binaries and archives into the repository. While I did correctly
abandon this practice early on, these files remained in the history of the repo,
and, as I had long since deleted all of the files, it was an extreme pain to get
rid of them all. So, in July of 2020 I decided to delete the old smlss
repository and start anew. This had the upside of deleting all bloated files
trapped in the repository like flies in amber, but had the downside of deleting
all the commit history from the project. OLD-HISTORY is the output of
```git log```
before I deleted the old repository.

I still barely know how to use Git -- I only use one master branch, and I
sometimes push things without realizing they are broken, and then just push
commits immediately after to fix them. Someday I will probably learn how to 
properly test things, but until that day, I hope that this reset helped to keep
the repository relatively lean, as I now am much more careful about the files
that are tracked in the repository.


# How to use smlss

1. Install Arch Linux. smlss does not do anything that it expects you would
have done while installing Arch itself. Follow the
[Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)
for help. In particular, make sure you have installed the ```base``` package.

2. Log in to your system as the user you are installing smlss as. Make sure you
are in that user's home directory.

3. Perform the following commands:
```
su # Enter your root password
pacman -Syu git # install Git in order to obtain smlss
exit
git clone https://gitlab.com/smlavine/smlss.git
smlss/smlss.sh
```


# What smlss does

smlss performs three main functions:

1. Installs software after an install of Arch Linux

2. Manages many user config files in one place, with symlinks to the necessary
places

3. Provides various scripts for your computing pleasure

smlss includes several programs from the "suckless" project. These programs are
meant to be configured by editing their source code, which is located in the
"suckless directory".


# What smlss doesn't

smlss is meant to streamline the installation of an Arch Linux
system. However, there are certain aspects of a system that are better done
manually. smlss __does not__ do the following:

- Install Arch Linux, including the ```base``` package, kernel, bootloader, etc.

- Install or distribute nonfree software

- Configure programs that require some information specific to an individual
user to function, such as git or thunderbird

Is there something that you'd like to see smlss do, that it currently doesn't?
Make an issue, or submit a pull request! Keep in mind, however, that I use
smlss myself, and so if a feature doesn't suit me personally, you might be
better off forking the project and adding what you'd like on your own.


# Contact

To contact me, Sebastian LaVine, send an email to <mail@smlavine.com>.


# FAQ (Feverishly Avoided Queries)

Q: Why is _feature X_ broken?

A: Because I broke it. Oops. Make an issue on the GitHub/GitLab page.


Q: Can I fork this project?

A: Yes, please do! Most software included in smlss is licensed under the MIT
license, however some (such as the "extract" script) is licensed under the
[GNU GPL](https://www.gnu.org/licenses/gpl-3.0.html), which has stricter
"copyleft" terms to be followed when software licensed under it is distributed
or modified.

