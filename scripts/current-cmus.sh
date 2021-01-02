#!/bin/sh
# Copyright (c) 2019-2021 Sebastian LaVine <mail@smlavine.com>
# Licensed under the MIT license. See smlss/MIT.txt for details.
#
# File:        current-cmus.sh
# Description: Transmits info of current song playing in cmus using dmenu.

get_value()
{
	echo "$(cmus-remote -C status | grep -o "$1.*$" | cut -d' ' -f2-)"
}

artist="$(get_value artist)"
album="$(get_value album)"
title="$(get_value title)"

info="$artist - $album - $title"

# If the music is improperly tagged, at least give the file name.
[ "$info" = " - album - " ] && info="$(get_value file)"

response="$(printf "Yank\nDuck\nSkip\nRepeat" | dmenu -i -b -p "$info")"
# Yank: Pastes song info into system clipboard
# Duck: Opens web browser and searches song info on DuckDuckGo
# Skip: Skips the song, going to next one
# Repeat: Starts the song over from the beginning

if [ "$response" = "Yank" ] 
then
	echo "$info" | xclip -selection c
elif [ "$response" = "Duck" ]
then
	firefox "https://www.duckduckgo.com/$info"
elif [ "$response" = "Skip" ]
then
	cmus-remote -n
elif [ "$response" = "Repeat" ]
then
	cmus-remote -k 0
fi
