#
# This policy configuration will be used by all products that
# inherit from Nameless
#

BOARD_SEPOLICY_DIRS += \
    vendor/nameless/sepolicy

BOARD_SEPOLICY_UNION += \
    mac_permissions.xml
