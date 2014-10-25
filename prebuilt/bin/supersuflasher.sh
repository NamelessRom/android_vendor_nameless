#!/sbin/sh
unzip -o -q /system/supersu.zip -d /tmp/supersu_1/
chmod 755 /tmp/supersu_1/META-INF/com/google/android/update-binary
sh /tmp/supersu_1/META-INF/com/google/android/update-binary 2 20 /system/supersu.zip
rm -rf /system/supersu.zip
touch /system/etc/.installed_su_daemon
