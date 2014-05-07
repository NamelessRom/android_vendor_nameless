# Additional packages
PRODUCT_PACKAGES += \
    Development \
    LatinIME \
    VoiceDialer \
    SoundRecorder \
    Basic \
    LiveWallpapersPicker \
    PhotoTable \
    libemoji

# Additional apps
PRODUCT_PACKAGES += \
    Apollo \
    CustomLauncher3 \
    DeviceControl \
    Flashlight \
    NamelessSetupWizard \
    UpdateCenter

# DSP Manager
PRODUCT_PACKAGES += \
    DSPManager \
    libcyanogen-dsp \
    audio_effects.conf

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

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libstagefright_soft_ffmpegadec \
    libstagefright_soft_ffmpegvdec \
    libFFmpegExtractor \
    libnamparser

# Extras
PRODUCT_PACKAGES += \
    procmem \
    procrank

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

######
# Additional Extras, enabled via flags
######

# Live Wallpapers
ifeq ($(USE_ALL_LIVEWALLPAPERS),true)
PRODUCT_PACKAGES += \
    Galaxy4 \
    HoloSpiralWallpaper \
    LiveWallpapers \
    MagicSmokeWallpapers \
    NoiseField \
    PhaseBeam \
    VisualizationWallpapers
endif
