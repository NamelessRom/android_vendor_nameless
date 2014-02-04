# Inherit common Nameless stuff
$(call inherit-product, vendor/nameless/config/common.mk)

# Inherit mobile stuff (like APNs)
$(call inherit-product, vendor/nameless/config/telephony.mk)
