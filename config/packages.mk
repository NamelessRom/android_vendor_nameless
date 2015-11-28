# Required packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    LatinIME \
    Profiles \

# Nameless packages
PRODUCT_PACKAGES += \
    DeviceControl \
    NamelessOTA \
    NamelessSettingsProvider \
    NamelessSetupWizard \
    Screencast \

# Additional packages
PRODUCT_PACKAGES += \
    CMFileManager \
    LockClock \
    PhotoTable \
    libemoji \
    CMSettingsProvider \
    CMResolver \
    ExactCalculator \

# Optional apps
PRODUCT_PACKAGES += \
    AudioFX \
    Eleven \
    Terminal \

# Launcher
PRODUCT_PACKAGES += \
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
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    pigz \

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
    7z \
    bzip2 \
    curl \
    unrar \
    unzip \
    vim \
    wget \
    zip \

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    Stk \
    CellBroadcastReceiver \

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# CM Platform Library
PRODUCT_PACKAGES += \
    org.cyanogenmod.platform-res \
    org.cyanogenmod.platform \
    org.cyanogenmod.platform.xml

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml \

# Nameless Platform Library
PRODUCT_PACKAGES += \
    org.namelessrom.platform \
    org.namelessrom.platform.xml \

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank \
    su
endif

######
# Additional Extras, enabled via flags
######

# debugging / development apps
ifeq ($(USE_ALL_DEVELOPMENT),true)
PRODUCT_PACKAGES += \
    Development \
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
