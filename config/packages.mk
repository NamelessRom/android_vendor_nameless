# Required packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    LatinIME \

# Additional packages
PRODUCT_PACKAGES += \
    Basic \
    LockClock \
    PhotoTable \
    SoundRecorder \
    libemoji \
    WhisperPush \

# Optional apps
PRODUCT_PACKAGES += \
    AudioFX \
    DeviceControl \
    Eleven \
    NamelessOTA \
    Screencast \
    Terminal \

# Launcher
PRODUCT_PACKAGES += \
    CMHome \
    Perception \

# Some live wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    LiveWallpapers \
    PhaseBeam \
    PhotoPhase \

# Additional tools
PRODUCT_PACKAGES += \
    libsepol \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    nano \
    htop \
    powertop \
    lsof \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    ntfsfix \
    ntfs-3g \
    sqlite3 \

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh \

# Extra tools
PRODUCT_PACKAGES += \
    vim \
    zip \
    unrar \

# Telephony packages
PRODUCT_PACKAGES += \
    Mms \
    Stk \
    CellBroadcastReceiver \

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libstagefright_soft_ffmpegadec \
    libstagefright_soft_ffmpegvdec \
    libFFmpegExtractor \
    libnamparser \

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml \

######
# Additional Extras, enabled via flags
######

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
    MagicSmokeWallpapers \
    NoiseField \
    VisualizationWallpapers
endif
