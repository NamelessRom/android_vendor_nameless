# Additional packages
PRODUCT_PACKAGES += \
	Development \
	LatinIME \
	VoiceDialer \
	SoundRecorder \
	Basic

# Additional apps
PRODUCT_PACKAGES += \
	Apollo \
	DashClock \
	DSPManager \
    Launcher3 \
	libcyanogen-dsp \
	audio_effects.conf

PRODUCT_PACKAGES += \
	CellBroadcastReceiver

# Additional tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    vim \
    nano \
    htop \
    powertop \
    lsof \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace

# Extras
PRODUCT_PACKAGES += \
    procmem \
    procrank

# Superuser
SUPERUSER_EMBEDDED := true
SUPERUSER_PACKAGE_PREFIX := com.android.settings.cyanogenmod.superuser

PRODUCT_PACKAGES += \
    Superuser \
    su

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=1

######
# Additional Extras, enabled via flags
######

ifneq ($(USE_TORCH),)
PRODUCT_PACKAGES += \
	Flashlight
endif
