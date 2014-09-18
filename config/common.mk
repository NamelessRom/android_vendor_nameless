PRODUCT_BRAND ?= nameless

# Versioning
include vendor/nameless/config/version.mk

# we are nameless rom
PRODUCT_COPY_FILES += \
    vendor/nameless/config/permissions/org.namelessrom.android.xml:system/etc/permissions/org.namelessrom.android.xml

# bootanimation
ifeq ($(PRODUCT_NO_BOOTANIMATION),)
PRODUCT_BOOTANIMATION := vendor/nameless/prebuilt/bootanimation/bootanimation.zip
endif

# get device client id base
ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# general properties
PRODUCT_PROPERTY_OVERRIDES += \
	keyguard.no_require_sim=true \
	ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
	ro.com.android.wifi-watchlist=GoogleGuest \
	ro.setupwizard.enterprise_mode=1 \
	ro.com.android.dateformat=MM-dd-yyyy \
	ro.com.android.dataroaming=false \
	persist.sys.root_access=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.debug.alloc=0

# disable multithreaded dextop for everything but nightlies and homemade
ifeq ($(filter NIGHTLY HOMEMADE,$(ROM_BUILDTYPE)),)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.dalvik.multithread=false
endif

# enable ADB authentication if not on eng build
ifneq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Tethering
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/nameless/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/nameless/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/nameless/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/nameless/prebuilt/bin/blacklist:system/addon.d/blacklist

# OTA signature check
PRODUCT_COPY_FILES += \
    vendor/nameless/prebuilt/bin/otasigcheck.sh:system/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
	vendor/nameless/prebuilt/etc/init.d/00banner:system/etc/init.d/00banner \
	vendor/nameless/prebuilt/bin/sysinit:system/bin/sysinit

# userinit support
PRODUCT_COPY_FILES += \
    vendor/nameless/prebuilt/etc/init.d/90userinit:system/etc/init.d/90userinit

# Init script file with nameless extras
PRODUCT_COPY_FILES += \
    vendor/nameless/prebuilt/etc/init.local.rc:root/init.nameless.rc

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/nameless/prebuilt/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/nameless/prebuilt/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Only let devices with mobile network access pull this
# WiFi-only devices don't need this
ifeq ($(PRODUCT_NO_TELEPHONY),)

# Telephony packages
PRODUCT_PACKAGES += \
    Mms \
    Stk \
    CellBroadcastReceiver

# Add apn's
include vendor/nameless/config/apns.mk

endif

# Additional packages
include vendor/nameless/config/packages.mk

# Proprietary
include vendor/nameless/proprietary/common.mk

# T-Mobile theme engine
include vendor/nameless/config/themes_common.mk

# Private Makefile
-include vendor/nameless/private/common.mk

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/nameless/overlay/common
