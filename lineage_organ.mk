#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from organ device
$(call inherit-product, device/xiaomi/organ/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_DEVICE := organ
PRODUCT_NAME := lineage_organ
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := REDMI Pad 2 Pro 5G
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="organ_global-user 16 BP2A.250605.031.A3 OS3.0.303.0.WPXINXM release-keys" \
    BuildFingerprint=Redmi/organ_global/organ:16/BP2A.250605.031.A3/OS3.0.303.0.WPXINXM:user/release-keys
