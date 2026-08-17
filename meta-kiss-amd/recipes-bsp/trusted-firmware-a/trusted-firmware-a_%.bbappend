COMPATIBLE_MACHINE:zynqmp = "^zynqmp$"

# Set to 1 if the platform has LTO enabled
TFA_LTO ?= ""

# Add an option to be able to indicate in the recipe if the plaform has LTO
# enabled, and only pass LD to make in case LTO is disabled, otherwise let
# it use $CC (as set by the Makefile).
# This change is inspired from an upstream fix in meta-arm:
# https://git.yoctoproject.org/meta-arm/commit/?id=3c07303388bf1fa286bbb6f5b5b6189635787103
EXTRA_OEMAKE += "${@bb.utils.contains('TFA_LTO', '1', "LD=''", "LD='" + remove_options_tail(d.getVar('LD')) + "'", d)}"
