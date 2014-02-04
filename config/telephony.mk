# World APN list
PRODUCT_COPY_FILES += \
    vendor/nameless/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# World SPN overrides list
PRODUCT_COPY_FILES += \
    vendor/nameless/prebuilt/common/etc/spn-conf.xml:system/etc/spn-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver

# This is only inherited by phones, so bring in phone setup
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
