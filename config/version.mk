# Versioning of the ROM

ifeq ($(BUILD_IS_JENKINS),1)
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
	ROM_VERSION := $(PLATFORM_VERSION)-$(TARGET_PRODUCT_SHORT)
else
ifneq ($(ROM_BUILDTIME_CUSTOM),)
	DATE := $(ROM_BUILDTIME_CUSTOM)
else
ifeq ($(ROM_BUILDTIME_LOCAL),y)
	DATE := $(shell date +%Y%m%d-%H%M%z)
else
	DATE := $(shell date -u +%Y%m%d)
endif
endif # BUILDTYPE_RELEASE

ROM_VERSION := $(PLATFORM_VERSION)-$(DATE)-$(TARGET_PRODUCT_SHORT)-$(ROM_BUILDTYPE)
endif

NAMELESS_VERSION := $(ROM_VERSION)

# Apply it to build.prop
PRODUCT_PROPERTY_OVERRIDES += \
	ro.modversion=NamelessROM-$(ROM_VERSION) \
	ro.nameless.version=$(ROM_VERSION) \
	ro.nameless.date=$(shell date +"%Y%m%d")
