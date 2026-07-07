FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:freiheit93 = " \
    file://optee.cfg \
    file://0001-binman-Add-optee-binary-to-i.MX9-platform-types.patch \
    file://0002-imx93-Add-support-for-OPTEE.patch \
    file://0003-imx93_frdm-Add-support-for-2CS-2GB-DRAM-support.patch \
    file://0004-imx93_frdm-Add-OP-TEE-device-tree-node.patch \
"

# We will embed boot firmwares, TFA images and optee image in the generated
# binary: we do depend on them.
DEPENDS:append:freiheit93 = " imx-boot-firmware-files trusted-firmware-a optee-os firmware-ele-imx"
EXTRA_OEMAKE:append:freiheit93 = " BINMAN_INDIRS=${RECIPE_SYSROOT}/firmware"

do_configure:append:freiheit93() {
    # Copy tfa, tee and ele firmware binaries in build directory, so they can be found by mkimage
    cp ${STAGING_DIR_HOST}/firmware/trusted-firmware-a/bl31.bin ${KCONFIG_CONFIG_ROOTDIR}/
    cp ${STAGING_DIR_HOST}/${nonarch_base_libdir}/firmware/tee-raw.bin ${KCONFIG_CONFIG_ROOTDIR}/tee.bin
    cp ${STAGING_DIR_HOST}/${nonarch_base_libdir}/firmware/imx/ele/${SECO_FIRMWARE_NAME} ${KCONFIG_CONFIG_ROOTDIR}/
}

do_deploy:append:freiheit93() {
    install -m 0644 ${KCONFIG_CONFIG_ROOTDIR}/flash.bin  ${DEPLOYDIR}/flash.bin

    # From meta-freescale uuu_bootloader_tag.bbclass
    # Create a tagged boot partition file for the SD card image file. The tag
    # contains the size of the boot partition image so UUU can easily find
    # the end of it in the SD card image file.
    #
    # IMPORTANT: The tagged boot partition file should never be used directly with
    #            UUU, as it can cause UUU to hang.
    cp ${DEPLOYDIR}/flash.bin ${DEPLOYDIR}/flash.bin.tagged
    stat -L -cUUUBURNXXOEUZX7+A-XY5601QQWWZ%sEND ${DEPLOYDIR}/flash.bin.tagged >> ${DEPLOYDIR}/flash.bin.tagged
}
