#!/bin/sh
# Copyright (c) 2020 Sebastian LaVine <seblavine@outlook.com>
# Licensed under the MIT license. See smlss/LICENSE for details.
#
# File: delete-last-screenshot.sh
# Description: Deletes the last screenshot that was taken.

# Directory containing the screenshots.
screenshot_path="$HOME/Documents/pictures/screenshots/"

file="$(ls -t1 "$screenshot_path" | head -1)"

view-last-screenshot.sh &

[ "$(printf "Y\nN" | dmenu -i -p "Are you sure you want to delete '$file'?")" = "Y" ] &&
	rm -f "$screenshot_path/$file"
