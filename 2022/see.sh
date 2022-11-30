#!/usr/bin/env sh
[ -z "$1" ] && echo "USAGE:
    ./see.sh <DAY>
" && exit -1

curl https://adventofcode.com/2022/day/$1 | node index | less