#!/sbin/sh

if [ -e /tmp/post_installation_extras/f2fs.sh ]; then
    mount | grep -q '/system type f2fs'
    F2FS=$?
    if [ $F2FS -eq 0 ]; then
        chmod 777 /tmp/post_installation_extras/f2fs.sh
        /tmp/post_installation_extras/f2fs.sh
    fi
fi