#!/bin/bash
# SuperUser Updater
# Please run this only once per Day!
URL=$(curl -Ls -o /dev/null -w %{url_effective} http://download.chainfire.eu/su$
AFTER_SLASH=${URL##*/}
echo "${AFTER_SLASH%%\?*}"
if [[ $(ls UPDATE-SuperSU*.zip) == ${AFTER_SLASH%%\?*} ]]; then
 echo "We have current Version!"
 rm vendor/nameless/proprietary/zips/supersu.zip
 cp UPDATE-SuperSU*.zip vendor/nameless/proprietary/zips/supersu.zip
 cd vendor/nameless/proprietary/ && git add -A && git commit -m "SuperUser"
else
 rm -rf UPDATE-SuperSU*.zip
 curl "${URL}?retrieve_file=1" -o "${AFTER_SLASH%%\?*}"
 rm vendor/nameless/proprietary/zips/supersu.zip
 cp UPDATE-SuperSU*.zip vendor/nameless/proprietary/zips/supersu.zip
 cd vendor/nameless/proprietary/ && git add -A && git commit -m "SuperUser"
fi
