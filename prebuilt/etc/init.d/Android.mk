LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE       := 00banner
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := 00banner
LOCAL_MODULE_PATH  := $(TARGET_OUT)/etc/init.d
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := 90userinit
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := 90userinit
LOCAL_MODULE_PATH  := $(TARGET_OUT)/etc/init.d
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
