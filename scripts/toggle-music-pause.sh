#!/bin/sh
# Copyright (c) 2020 Sebastian LaVine <seblavine@outlook.com>
# Licensed under the MIT license. See smlss/LICENSE for details.
#
# File: toggle-music-pause.sh
# Description: Toggles music playback, if music is playing in either pianobar or
#			   cmus. 

pidof cmus && cmus-remote -u
pidof pianobar && echo -n ' ' > ~/.config/pianobar/ctl
