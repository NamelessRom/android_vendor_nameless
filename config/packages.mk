# Additional packages
PRODUCT_PACKAGES += \
    Basic \
    LatinIME \
    LiveWallpapersPicker \
    PhotoTable \
    SoundRecorder

# Additional apps
PRODUCT_PACKAGES += \
    Apollo \
    CustomLauncher3 \
    DashClock \
    DeviceControl \
    Flashlight \
    NamelessProvider \
    NamelessSetupWizard \
    SuperSU \
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
    sqlite3 \
    libemoji

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libstagefright_soft_ffmpegadec \
    libstagefright_soft_ffmpegvdec \
    libFFmpegExtractor \
    libnamparser

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

######
# Additional Extras, enabled via flags
######

# unneeded bloat
ifeq ($(USE_ALL_BLOAT),true)
PRODUCT_PACKAGES += \
    VoiceDialer
endif

# debugging / development apps
ifeq ($(USE_ALL_DEVELOPMENT),true)
PRODUCT_PACKAGES += \
    Development \
    procmem \
    procrank \
    gdbserver \
    micro_bench \
    oprofiled \
    strace
endif

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
