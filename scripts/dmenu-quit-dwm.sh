#!/bin/sh
# Copyright (c) 2019-2020 Sebastian LaVine <mail@smlavine.com>
# Licensed under the MIT license. See smlss/LICENSE for details.
#
# File:        dmenu-quit-dwm.sh
# Description: Quits dwm, but first prompts the user with a dmenu prompt asking
#              if they are sure.

if [ "$(printf "Y\nN" | dmenu -i -p "Are you sure?")" = "Y" ]
then
	pkill dwm
fi
