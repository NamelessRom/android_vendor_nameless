# Additional packages
PRODUCT_PACKAGES += \
    Development \
    LatinIME \
    VoiceDialer \
    SoundRecorder \
    Basic \
    QuickSearchBox \
    LiveWallpapersPicker \
    PhotoTable \
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

# Device Control
ifneq ($(USE_DEVICE_CONTROL),)
PRODUCT_PACKAGES += \
    DeviceControl
endif

# Torch aka Flashlight
ifneq ($(USE_TORCH),)
PRODUCT_PACKAGES += \
    Flashlight
endif

# Live Wallpapers
ifneq ($(USE_ALL_LIVEWALLPAPERS),)
PRODUCT_PACKAGES += \
    Galaxy4 \
    HoloSpiralWallpaper \
    LiveWallpapers \
    MagicSmokeWallpapers \
    NoiseField \
    PhaseBeam \
    VisualizationWallpapers
endif