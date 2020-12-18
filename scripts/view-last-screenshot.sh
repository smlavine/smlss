#!/bin/sh
# Copyright (c) 2019-2020 Sebastian LaVine <mail@smlavine.com>
# Licensed under the MIT license. See smlss/MIT.txt for details.
#
# File:        last-screenshot.sh
# Description: Opens the last screenshot taken in sxiv.

# Directory containing the screenshots.
screenshot_path="$HOME/Documents/pictures/screenshots/"

sxiv "$screenshot_path/$(ls -t1 "$screenshot_path" | head -1)"
