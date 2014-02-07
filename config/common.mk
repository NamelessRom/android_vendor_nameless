PRODUCT_BRAND ?= nameless

# Superuser
SUPERUSER_EMBEDDED := true
SUPERUSER_PACKAGE_PREFIX := com.android.settings.cyanogenmod.superuser

# bootanimation
PRODUCT_COPY_FILES += \
	vendor/nameless/prebuilt/bootanimation/bootanimation.zip:system/media/bootanimation.zip

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

# enable ADB authentication if not on eng build
ifneq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/nameless/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/nameless/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/nameless/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/nameless/prebuilt/bin/blacklist:system/addon.d/blacklist

# init.d support
PRODUCT_COPY_FILES += \
	vendor/nameless/prebuilt/etc/init.d/00banner:system/etc/init.d/00banner \
	vendor/nameless/prebuilt/bin/sysinit:system/bin/sysinit

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/nameless/prebuilt/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

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

# Additional packages
-include vendor/nameless/config/packages.mk

# T-Mobile theme engine
include vendor/nameless/config/themes_common.mk

# Versioning
-include vendor/nameless/config/version.mk

# Private Makefile
-include vendor/nameless/private/common.mk

# Common sepolicy
-include vendor/nameless/sepolicy/sepolicy.mk

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/nameless/overlay/common

# Only let devices with mobile network access pull this
# WiFi-only devices don't need this
ifeq ($(PRODUCT_NO_TELEPHONY),)
# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/nameless/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
    Mms \
    Stk \
    CellBroadcastReceiver
endif
