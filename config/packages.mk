# Additional packages
PRODUCT_PACKAGES += \
	Development \
	LatinIME \
	VideoEditor \
	VoiceDialer \
	SoundRecorder \
	Basic

# Additional apps
PRODUCT_PACKAGES += \
	Apollo \
	DashClock

ifneq ($(USE_TORCH),)
PRODUCT_PACKAGES += \
	Flashlight
endif

PRODUCT_PACKAGES += \
	CellBroadcastReceiver

# Additional tools
PRODUCT_PACKAGES += \
	openvpn \
	e2fsck \
	mke2fs \
	tune2fs \
	bash \
	vim \
	nano \
	htop \
	powertop \
	lsof

