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
    DashClock \
    DeviceControl \
    NamelessCenter \
    NamelessProvider \
    NamelessSetupWizard \
    SuperSU \

# Launcher
PRODUCT_PACKAGES += \
    CMHome \
    CustomLauncher3 \

# DSP Manager
ifneq ($(USE_DSP_MANAGER),false)
PRODUCT_PACKAGES += \
    DSPManager \
    libcyanogen-dsp \
    audio_effects.conf
endif

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

# F2FS filesystem
PRODUCT_PACKAGES += \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    f2fstat

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

# Nameless Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.namelessrom.hardware \
    org.namelessrom.hardware.xml

######
# Additional Extras, enabled via flags
######

# remove torch on unsupported devices
ifeq ($(USE_NO_TORCH),)
PRODUCT_PACKAGES += \
    Torch
endif

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
