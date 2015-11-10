# Versioning of NamelessRom

PRODUCT_VERSION_MAJOR = 3
PRODUCT_VERSION_MINOR = 0

PRODUCT_VERSION_FINAL = $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)

ifneq ($(BUILD_BUILDTYPE),)
    ROM_BUILDTYPE = $(BUILD_BUILDTYPE)
else
    ROM_BUILDTYPE := NIGHTLY
endif

ifdef BUILDTYPE_RELEASE
    ROM_BUILDTYPE := RELEASE
endif

ifndef ROM_BUILDTYPE
    ROM_BUILDTYPE := HOMEMADE
endif

TARGET_PRODUCT_SHORT := $(TARGET_PRODUCT)
TARGET_PRODUCT_SHORT := $(subst nameless_,,$(TARGET_PRODUCT_SHORT))

# Build the final version string
ifdef BUILDTYPE_RELEASE
    ROM_VERSION := $(PRODUCT_VERSION_FINAL)-$(TARGET_PRODUCT_SHORT)
else
ifneq ($(ROM_BUILDTIME_CUSTOM),)
    DATE := $(ROM_BUILDTIME_CUSTOM)
else
ifeq ($(ROM_BUILDTIME_LOCAL),y)
    DATE := $(shell date +%Y%m%d-%H%M%z)
else
    DATE := $(shell date +%Y%m%d)
endif
endif # BUILDTYPE_RELEASE

ROM_VERSION := $(PRODUCT_VERSION_FINAL)-$(TARGET_PRODUCT_SHORT)-$(DATE)
endif

NAMELESS_VERSION := $(ROM_VERSION)

# Apply it to build.prop
PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=n-$(ROM_VERSION) \
    ro.nameless.version=$(ROM_VERSION) \
    ro.nameless.date=$(shell date +"%Y%m%d") \
    ro.nameless.releasetype=$(ROM_BUILDTYPE) \

# security patch level
PLATFORM_SECURITY_PATCH := 2015-11-01
