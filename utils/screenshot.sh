#!/bin/sh
set -x
D=$(date +"%Y%m%d%H%M%S")
size=$($1/utils/adb shell "fbset|sed -n -e's/^mode.*\"\([0-9]\+x[0-9]\+\)[-\"].*$/\1/p'")
DEST=$2

$1/utils/adb shell mirscreencast -m /var/run/mir_socket -n 1 -f /tmp/${D}.rgba
$1/utils/adb pull /tmp/${D}.rgba /tmp/ 2>/dev/null
$1/utils/convert -alpha off -depth 8 -size $size rgba:/tmp/${D}.rgba "$DEST"/${D}.png

echo "$DEST/${D}.png"
