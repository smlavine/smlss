#!/bin/sh
# Copyright (c) 2021 Sebastian LaVine <mail@smlavine.com>
# Licensed under the MIT license. See smlss/MIT.txt for details.
#
# File:        rs
# Description: Turns on (or off) the blue light filter.
# Options:     -o	Turn off the blue light filter.

options="o"
while getopts "$options" o; do
	case "$o" in
		o) redshift -x && exit;;
		*) echo "USAGE: rs [-$options]" && exit;;
	esac
done

redshift -PO 3500k
