#!/sbin/sh
#
# Backup and restore addon /system files
#

export C=/tmp/backupdir
export S=/system
export V=4.4

# Preserve /system/addon.d in /tmp/addon.d
preserve_addon_d() {
  mkdir -p /tmp/addon.d/
  cp -a /system/addon.d/* /tmp/addon.d/
  chmod 755 /tmp/addon.d/*.sh
}

# Restore /system/addon.d in /tmp/addon.d
restore_addon_d() {
  cp -a /tmp/addon.d/* /system/addon.d/
  rm -rf /tmp/addon.d/
}

# Backup Xposed Framework (bin/app_process)
xposed_backup()
{
	if ( grep -ciE ".*with Xposed support \\(version (.+)\\).*" /system/bin/app_process )
		then
			cp /system/bin/app_process /tmp/backupdir/
	fi
}

# Restore Xposed Framework (bin/app_process)
xposed_restore()
{
	if [ -f /tmp/backupdir/app_process ]
		then
			mv /system/bin/app_process /system/bin/app_process.orig
			cp /tmp/backupdir/app_process /system/bin/
	fi
}

# Proceed only if /system is the expected major and minor version
check_prereq() {
if ( ! grep -q "^ro.build.version.release=$V.*" /system/build.prop ); then
  echo "Not backing up files from incompatible version: $V"
  exit 127
fi
}

check_blacklist() {
  if [ -f /system/addon.d/blacklist ];then
      ## Discard any known bad backup scripts
      cd /$1/addon.d/
      for f in *sh; do
          s=$(md5sum $f | awk {'print $1'})
          grep -q $s /system/addon.d/blacklist && rm -f $f
      done
  fi
}

# Execute /system/addon.d/*.sh scripts with $1 parameter
run_stage() {
for script in $(find /tmp/addon.d/ -name '*.sh' |sort -n); do
  $script $1
done
}

case "$1" in
  backup)
    mkdir -p $C
    xposed_backup
    check_prereq
    check_blacklist system
    preserve_addon_d
    run_stage pre-backup
    run_stage backup
    run_stage post-backup
  ;;
  restore)
    xposed_restore
    check_prereq
    check_blacklist tmp
    run_stage pre-restore
    run_stage restore
    run_stage post-restore
    restore_addon_d
    rm -rf $C
    sync
  ;;
  *)
    echo "Usage: $0 {backup|restore}"
    exit 1
esac

exit 0
