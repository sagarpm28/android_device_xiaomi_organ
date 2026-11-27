#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/organ

# Inherit proprietary vendor blobs
$(call inherit-product, vendor/xiaomi/organ/organ-vendor.mk)

# Vendor blobs frozen at API 34 (VNDK v34), shipping API 35
PRODUCT_EXTRA_VNDK_VERSIONS := 34
PRODUCT_SHIPPING_API_LEVEL := 35
PRODUCT_VENDOR_PROPERTIES += ro.board.api_level=34

# Dynamic partitions + Virtual A/B
PRODUCT_USE_DYNAMIC_PARTITIONS := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/vabc_features.mk)
PRODUCT_VIRTUAL_AB_COMPRESSION_METHOD := lz4

# A/B & fastbootd
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier \
    otapreopt_script \
    fastbootd

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

# Tablet, 320 dpi (xhdpi)
PRODUCT_CHARACTERISTICS := tablet
PRODUCT_AAPT_CONFIG := normal large xlarge
PRODUCT_AAPT_PREF_CONFIG := xhdpi
PRODUCT_PRODUCT_PROPERTIES += ro.sf.lcd_density=320

# Emulated storage
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# First-stage fstab (vendor_boot ramdisk)
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

# GKI kernel
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/prebuilt/gki/Image:kernel

# Stock vendor uses HIDL HALs
PRODUCT_HIDL_ENABLED := true
PRODUCT_PACKAGES += \
    hwservicemanager \
    android.hidl.allocator@1.0-service \
    android.hidl.memory@1.0-impl

# Recovery packages
PRODUCT_PACKAGES += \
    adbd.recovery \
    cgroups.recovery.json \
    charger.recovery \
    init_second_stage.recovery \
    ld.config.recovery.txt \
    linker.recovery \
    otacerts.recovery \
    recovery \
    servicemanager.recovery \
    shell_and_utilities_recovery \
    watchdogd.recovery \
    odm-build.prop \
    vendor_compatibility_matrix.xml

# SELinux genfs_labels_version
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/sepolicy/genfs_labels_version.txt:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/genfs_labels_version.txt

# Kernel UFFD GC
PRODUCT_ENABLE_UFFD_GC := true

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Rootdir
PRODUCT_PACKAGES += \
    early_eth.sh \
    init.class_main.sh \
    init.crda.sh \
    init.kernel.early_boot-memory.sh \
    init.kernel.post_boot-memory.sh \
    init.kernel.post_boot-volcano.sh \
    init.kernel.post_boot-volcano_2_2_1.sh \
    init.kernel.post_boot-volcano_3_2_1.sh \
    init.kernel.post_boot-volcano_3_3_1.sh \
    init.kernel.post_boot-volcano_4_2_1.sh \
    init.kernel.post_boot-volcano_4_3_0.sh \
    init.kernel.post_boot-volcano_default_4_3_1.sh \
    init.kernel.post_boot.sh \
    init.mdm.sh \
    init.qcom.class_core.sh \
    init.qcom.coex.sh \
    init.qcom.early_boot.sh \
    init.qcom.efs.sync.sh \
    init.qcom.post_boot.sh \
    init.qcom.sdio.sh \
    init.qcom.sensors.sh \
    init.qcom.sh \
    init.qcom.usb.sh \
    init.qti.display_boot.sh \
    init.qti.graphics.sh \
    init.qti.kernel.debug-volcano.sh \
    init.qti.kernel.debug.sh \
    init.qti.kernel.early_debug-volcano.sh \
    init.qti.kernel.early_debug.sh \
    init.qti.kernel.sh \
    init.qti.media.sh \
    init.qti.qcv.sh \
    init.qti.write.sh \
    qca6234-service.sh \
    system_dlkm_modprobe.sh \
    vendor_modprobe.sh \
    fstab.qcom \
    init.qcom.factory.rc \
    init.qcom.rc \
    init.qcom.usb.rc \
    init.qti.kernel.rc \
    init.qti.ufs.rc \
    init.target.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
