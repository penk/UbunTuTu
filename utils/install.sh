#!/bin/bash
#set -x 

$1/utils/adb push $2 /tmp/
CLICK=`basename $2`
$1/utils/adb shell pkcon -p install-local --allow-untrusted /tmp/$CLICK
