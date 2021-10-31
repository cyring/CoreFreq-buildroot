COREFREQ_VERSION = 1.88.1
COREFREQ_SITE = $(call github,cyring,CoreFreq,$(COREFREQ_VERSION))
COREFREQ_INTSTALL_STAGING = YES

define COREFREQ_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -j1 -C $(@D) all
endef

define COREFREQ_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/corefreqd $(STAGING_DIR)/bin/corefreqd
	$(INSTALL) -D -m 0755 $(@D)/corefreq-cli $(STAGING_DIR)/bin/corefreq-cli
endef

define COREFREQ_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/corefreqd $(TARGET_DIR)/bin/corefreqd
	$(INSTALL) -D -m 0755 $(@D)/corefreq-cli $(TARGET_DIR)/bin/corefreq-cli
endef

$(eval $(kernel-module))
$(eval $(generic-package))
