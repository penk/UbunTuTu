#!/bin/sh
set -x
D=$(date +"%Y%m%d%H%M%S")
DEST=$2

echo "DEST: $DEST"
echo "\$3: $3"

if [ "$3" = "export" ]
then
    $1/utils/adb shell syncevolution --export /home/phablet/Documents/utcontacts-${D}.vcf backend=evolution-contacts
    $1/utils/adb pull /home/phablet/Documents/utcontacts-${D}.vcf $DEST 2>/dev/null
    $1/utils/adb shell rm /home/phablet/Documents/utcontacts-${D}.vcf
    echo "$DEST/utcontacts-${D}.vcf"
elif [ "$3" = "import" ]
then
    $1/utils/adb shell push ${DEST} /home/phablet/Documents/
    $1/utils/adb shell syncevolution --import /home/phablet/Documents/*.vcf backend=evolution-contacts
    echo "import ${DEST} ok"
else
    echo "$3 is error"
fi
