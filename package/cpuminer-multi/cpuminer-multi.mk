################################################################################
#
# cpuminer-multi
#
################################################################################

# CPUMINER_MULTI_VERSION = linux
# 2022/10/23
CPUMINER_MULTI_VERSION = d2927ed23b1d0eacd067c320fce64e6610737adb
CPUMINER_MULTI_SITE = $(call github,tpruvot,cpuminer-multi,$(CPUMINER_MULTI_VERSION))
CPUMINER_MULTI_DEPENDENCIES = host-autoconf openssl libcurl brotli libidn2 libpsl libssh2 nghttp2
CPUMINER_MULTI_LICENSE = GPL-2.0
CPUMINER_MULTI_LICENSE_FILES = COPYING

# benchmark on 64bit : 3.13 kH/s, sha256d 1469 kH/s. i think it too slow...
# benchmark on 32bit : 
CPUMINER_MULTI_CONF_ENV += CFLAGS="-Ofast -fuse-linker-plugin -ftree-loop-if-convert-stores -march=armv8-a+crc -mtune=cortex-a72 -ftree-vectorize"
CPUMINER_MULTI_CONF_ENV += LDFLAGS="-march=armv8-a+crc -mtune=cortex-a72"

CPUMINER_MULTI_CONF_OPTS = \
	--disable-assembly \
	--with-crypto \
	--with-curl

# This package uses autoconf, but not automake, so we need to call
# their special autogen.sh script, and have custom target and staging
# installation commands.

define CPUMINER_MULTI_RUN_AUTOGEN
	cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
CPUMINER_MULTI_PRE_CONFIGURE_HOOKS += CPUMINER_MULTI_RUN_AUTOGEN

define CPUMINER_MULTI_INSTALL_TARGET_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		PREFIX=/usr \
		STRIP=/bin/true \
		DESTDIR=$(TARGET_DIR) \
		install
endef

$(eval $(autotools-package))
