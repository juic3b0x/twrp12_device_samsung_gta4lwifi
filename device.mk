#
# Copyright (C) 2022 The Android Open Source Project
# Copyright (C) 2022 The TWRP Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 31

# API
PRODUCT_SHIPPING_API_LEVEL := 30

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.crypto.volume.metadata.method=dm-default-key \
    ro.crypto.dm_default_key.options_format.version=2 \
    ro.crypto.volume.options=::v2

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Screen
TARGET_SCREEN_WIDTH := 1200
TARGET_SCREEN_HEIGHT := 2000

# TWRP Configuration
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_REPACKTOOLS := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TW_CUSTOM_CPU_TEMP_PATH := "/sys/devices/virtual/thermal/thermal_zone41/temp"
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TARGET_USES_MKE2FS := true
TW_NO_SCREEN_BLANK := true
TW_EXCLUDE_APEX := true
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 255
TW_NO_REBOOT_BOOTLOADER := true
TW_HAS_DOWNLOAD_MODE := true
TW_BACKUP_EXCLUSIONS := /data/fonts

# Crypto
TW_USE_FSCRYPT_POLICY := 2
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
PLATFORM_SECURITY_PATCH := 2127-12-31
VENDOR_SECURITY_PATCH := 2127-12-31
PLATFORM_VERSION := 127
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
BOARD_USES_QCOM_FBE_DECRYPTION := true

TW_LOAD_VENDOR_MODULES := "sec_cmd.ko sec_common_fn.ko sec_secure_touch.ko sec_tclm_v2.ko sec_tsp_dumpkey.ko sec_tsp_log.ko stm_ts.ko"

# Dependencies
TARGET_RECOVERY_DEVICE_MODULES += \
    libion

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(COMMON_PATH)

# Copy modules for depmod
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/sec_cmd.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/sec_cmd.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/sec_common_fn.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/sec_common_fn.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/sec_secure_touch.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/sec_secure_touch.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/sec_tclm_v2.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/sec_tclm_v2.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/sec_tsp_dumpkey.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/sec_tsp_dumpkey.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/sec_tsp_log.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/sec_tsp_log.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/1.1/stm_ts.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/stm_ts.ko

# qcom decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe
