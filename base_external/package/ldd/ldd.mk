LDD_VERSION = 16312be673f27c93a593c5fd3bf9cae47a69d4a0
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-lomangs.git
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

# Build rootfs subdirectories sequentially using Buildroot infra
LDD_MODULE_SUBDIRS = misc-modules scull

$(eval $(kernel-module))
$(eval $(generic-package))
