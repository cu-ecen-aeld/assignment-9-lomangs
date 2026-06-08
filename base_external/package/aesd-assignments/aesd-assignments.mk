
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = 'HEAD'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
#AESD_ASSIGNMENTS_VERSION = 0d215d1914ad5633e14e70e017cdfdbe69e00670
AESD_ASSIGNMENTS_VERSION = f8e060d321e927207e0904f14ca29b0f8b9f2c75
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-lomangs.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

AESD_ASSIGNMENTS_MODULE_SUBDIRS = aesd-char-driver

define AESD_ASSIGNMENTS_BUILD_CMDS
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
    # Create target directories
    $(INSTALL) -d 0755 $(TARGET_DIR)/usr/bin
    $(INSTALL) -d 0755 $(TARGET_DIR)/usr/bin/conf

    # Install the writer binary, finder.sh, and tester.sh to /usr/bin
    $(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/
    $(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/
    $(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/

    # Install the required configuration files
    $(INSTALL) -m 0644 $(@D)/finder-app/conf/* $(TARGET_DIR)/usr/bin/conf/
    $(INSTALL) -m 0644 $(@D)/conf/* $(TARGET_DIR)/usr/bin/conf/

	$(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin

    $(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/aesdsocket
    $(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket

   	# Install driver loading wrappers to /usr/bin
	$(INSTALL) -m 0755 -D $(@D)/aesd-char-driver/aesdchar_load $(TARGET_DIR)/usr/bin/aesdchar_load
	$(INSTALL) -m 0755 -D $(@D)/aesd-char-driver/aesdchar_unload $(TARGET_DIR)/usr/bin/aesdchar_unload

	# Install compiled kernel driver module binary
	$(INSTALL) -m 0644 -D $(@D)/aesd-char-driver/aesdchar.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/aesdchar.ko

	# Install S90 & S91 Initialization Init Daemons into /etc/init.d/
    $(INSTALL) -m 0755 -D $(BR2_EXTERNAL_project_base_PATH)/package/aesd-assignments/S90aesdchar $(TARGET_DIR)/etc/init.d/S90aesdchar
    $(INSTALL) -m 0755 -D $(BR2_EXTERNAL_project_base_PATH)/package/aesd-assignments/S91aesdsocket $(TARGET_DIR)/etc/init.d/S91aesdsocket
endef

$(eval $(kernel-module))
$(eval $(generic-package))
