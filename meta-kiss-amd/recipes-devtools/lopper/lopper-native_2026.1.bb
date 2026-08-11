SUMMARY = "Device Tree Lopper"
DESCRIPTION = "Tool for manipulation of system device tree files"
SECTION = "bootloader"

BRANCH = "xlnx_rel_v${PV}"
SRC_URI = "git://github.com/Xilinx/lopper.git;branch=${BRANCH};protocol=https"
SRCREV = "e8883d44168d11c86b207ddf82ba7735a46391b7"

LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=8e5f5f691f01c9fdfa7a7f2d535be619"

inherit setuptools3 native

PYPA_WHEEL = "${PIP_INSTALL_DIST_PATH}/${BPN}-${PV}-*.whl"
