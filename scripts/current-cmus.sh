#!/bin/sh
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
#
# File:        current-cmus.sh
# Description: Transmits info of current song playing in cmus using dmenu.
# Options:     
# Arguments:

get_value()
{
	echo "$(cmus-remote -C status | grep "tag $1" | cut -d' ' -f3-)"
}

artist="$(get_value artist)"
album="$(get_value album)"
title="$(get_value title)"

info="$artist - $album - $title"

if [ "$info" = " -  - " ] # no music playing or not tagged
then
	dmenu -b -p "No music playing OR music improperly tagged." < /dev/null
else

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
fi
