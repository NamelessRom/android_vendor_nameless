#!/sbin/sh
mkdir -p /tmp/supersu_1/
unzip -o -q /system/supersu.zip -d /tmp/supersu_1/
rm -rf /system/supersu.zip
chmod 755 /tmp/supersu_1/META-INF/com/google/android/update-binary
sh /tmp/supersu_1/META-INF/com/google/android/update-binary 2 20 /system/supersu.zip
