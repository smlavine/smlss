#!/bin/sh
# Copyright (c) 2019-2020 Sebastian LaVine <seblavine@outlook.com>
# Licensed under the MIT license. See smlss/LICENSE for details.
#
# File: toggle-intl-key.sh
# Description: Toggles between the US and US INTL keyboard layouts.

if [ "$(setxkbmap -query | grep variant | awk '{print $2}')" = "intl" ]
then
    setxkbmap us
else
    setxkbmap us -variant intl
fi
