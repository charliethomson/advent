#!/usr/bin/env sh
[ -z "$1" ] && echo "USAGE:
    ./see.sh <DAY>

NOTE: glow is required - install for your system @ https://github.com/charmbracelet/glow#installation
" && exit -1

if ! (glow -h > /dev/null); then echo "\nGlow is required - install for your system @ https://github.com/charmbracelet/glow#installation" && exit -1
fi


if [ ! -f ./day_$1/prompt.day_$1.md ]
then
    curl https://adventofcode.com/2021/day/$1 | node ./index.js > ./day_$1/prompt.day_$1.md
fi
glow ./day_$1/prompt.day_$1.md -p