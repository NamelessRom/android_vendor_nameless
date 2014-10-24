#!/sbin/sh
mkdir -p /tmp/supersu_1/
unzip -o -q /system/supersu.zip -d /tmp/supersu_1/
chmod 755 /tmp/supersu_1/META-INF/com/google/android/update-binary
sh /tmp/supersu_1/META-INF/com/google/android/update-binary 2 20 /system/supersu.zip
rm -rf /system/supersu.zip
#shut up cwm recovery
mount /system
mount /data
mount -o rw,remount /system
mount -o rw,remount /system /system
mount -o rw,remount /
mount -o rw,remount / /
touch /system/etc/.installed_su_daemon
ln -sf /system/xbin/su /system/bin/su
