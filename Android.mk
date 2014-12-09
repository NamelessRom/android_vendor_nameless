LOCAL_PATH := $(call my-dir)

# init.d
include vendor/nameless/prebuilt/etc/init.d/Android.mk

# libs
-include vendor/nameless/proprietary/libs/Android.mk

# prebuilt
-include vendor/nameless/proprietary/prebuilt/Android.mk
