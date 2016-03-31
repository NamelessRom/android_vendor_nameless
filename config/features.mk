# we are nameless rom
PRODUCT_COPY_FILES += \
    vendor/nameless/config/permissions/org.namelessrom.android.xml:system/etc/permissions/org.namelessrom.android.xml

# and we do support cm features
PRODUCT_COPY_FILES += \
    vendor/nameless/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml \
    vendor/nameless/config/permissions/org.cyanogenmod.appsuggest.xml:system/etc/permissions/org.cyanogenmod.appsuggest.xml \
    vendor/nameless/config/permissions/org.cyanogenmod.livedisplay.xml:system/etc/permissions/org.cyanogenmod.livedisplay.xml \
    vendor/nameless/config/permissions/org.cyanogenmod.livelockscreen.xml:system/etc/permissions/org.cyanogenmod.livelockscreen.xml \
    vendor/nameless/config/permissions/org.cyanogenmod.partner.xml:system/etc/permissions/org.cyanogenmod.partner.xml \
    vendor/nameless/config/permissions/org.cyanogenmod.performance.xml:system/etc/permissions/org.cyanogenmod.performance.xml \
    vendor/nameless/config/permissions/org.cyanogenmod.profiles.xml:system/etc/permissions/org.cyanogenmod.profiles.xml \
    vendor/nameless/config/permissions/org.cyanogenmod.statusbar.xml:system/etc/permissions/org.cyanogenmod.statusbar.xml \
    vendor/nameless/config/permissions/org.cyanogenmod.telephony.xml:system/etc/permissions/org.cyanogenmod.telephony.xml \
    vendor/nameless/config/permissions/org.cyanogenmod.theme.xml:system/etc/permissions/org.cyanogenmod.theme.xml \
    vendor/nameless/config/permissions/org.cyanogenmod.weather.xml:system/etc/permissions/org.cyanogenmod.weather.xml \

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml
