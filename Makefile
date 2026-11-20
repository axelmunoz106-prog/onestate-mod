TARGET := iphone:clang:16.5:16.0
ARCHS := arm64
LIBRARY_NAME := modmenu
modmenu_FILES := main.mm menu.mm hooks.mm
modmenu_CFLAGS := -fobjc-arc -std=c++17 -DNDEBUG -w
modmenu_LDFLAGS := -Wl,-undefined,dynamic_lookup -Wl,-not_for_dyld_shared_cache
modmenu_FRAMEWORKS := UIKit Foundation
include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/library.mk
