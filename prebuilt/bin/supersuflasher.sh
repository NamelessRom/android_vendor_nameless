#!/sbin/sh
unzip -o -q  /system/supersu.zip -d /tmp/supersu/
chmod 755 /tmp/supersu/META-INF/com/google/android/update-binary
sh /tmp/supersu/META-INF/com/google/android/update-binary >> /tmp/output
rm -rf /system/supersu.zip
