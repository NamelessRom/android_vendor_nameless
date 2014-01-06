# Additional packages
PRODUCT_PACKAGES += \
    Development \
    LatinIME \
    VoiceDialer \
    SoundRecorder \
    Basic \
    libemoji

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
PRODUCT_PACKAGES += \
    Superuser \
    su

PRODUCT_COPY_FILES += \
    external/koush/Superuser/init.superuser.rc:root/init.superuser.rc

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

######
# Additional Extras, enabled via flags
######

ifneq ($(USE_DEVICE_CONTROL),)
PRODUCT_PACKAGES += \
    DeviceControl \
endif

ifneq ($(USE_TORCH),)
PRODUCT_PACKAGES += \
    Flashlight
endif
