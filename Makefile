HOST ?= 0
KILL ?= 0
ROOTLESS ?= 0

export SYSROOT = $(THEOS)/sdks/iPhoneOS16.5.sdk #Đường dẫn SDK

ifeq ($(ROOTLESS),1)
export THEOS_PACKAGE_SCHEME=rootless
endif

DEBUG = 0
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

TARGET := iphone:clang:latest:15.0
INSTALL_TARGET_PROCESSES = SpringBoard

export ARCHS = arm64 arm64e #Nền tảng hỗ trợ
export TARGET = iphone:clang:latest:15.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BadgeBreathing #Các tệp nguồn
BadgeBreathing_FILES = Tweak.xm
BadgeBreathing_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

ifeq ($(KILL),0) #Sau khi cài đặt
after-install::
	install.exec "killall -9 SpringBoard"
else
after-install::
	install.exec "killall -9 Preferences && uiopen prefs:root=BadgeBreathing"
endif
