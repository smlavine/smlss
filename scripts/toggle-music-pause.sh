#!/bin/sh
# Copyright (c) 2020-2021 Sebastian LaVine <mail@smlavine.com>
# Licensed under the MIT license. See smlss/MIT.txt for details.
#
# File:        toggle-music-pause.sh
# Description: Toggles music playback, if music is playing in either pianobar or
#              cmus. 

pidof cmus && cmus-remote -u
pidof pianobar && echo -n ' ' > ~/.config/pianobar/ctl
