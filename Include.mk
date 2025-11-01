MAKEFILE_PATH := $(lastword $(MAKEFILE_LIST))
ROOT_DIR := $(dir $(abspath $(MAKEFILE_PATH)))

# Project configuration
BUILD_ROOT_DIR = $(ROOT_DIR)/build/x64
BUILD_ROOT_OBJ_DIR = $(BUILD_ROOT_DIR)/obj
BUILD_ROOT_BIN_DIR = $(BUILD_ROOT_DIR)/bin
BUILD_ROOT_LIB_DIR = $(BUILD_ROOT_DIR)/lib

# Get current directory relative to ROOT_DIR
CURRENT_DIR := $(patsubst $(ROOT_DIR)%,%,$(CURDIR))
BUILD_DIR := $(BUILD_ROOT_OBJ_DIR)/$(CURRENT_DIR)

# Build objects in mirrored directory structure
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

CXX ?= g++
CXXFLAGS ?= -Wall -Wextra -std=c++11 -O2 -MMD -MP
LDFLAGS = -L$(BUILD_ROOT_LIB_DIR)

ifdef TARGET
all: $(BUILD_DIR)/$(TARGET)

$(BUILD_DIR)/$(TARGET): $(OBJS)
	@echo "Linking Target: $@"
	@mkdir -p $(dir $@)
	@mkdir -p $(BUILD_ROOT_BIN_DIR)	
	$(CXX) $(CXXFLAGS) $(OBJS) $(LDFLAGS) $(LDLIBS) -o $@
	@cp $@ $(BUILD_ROOT_BIN_DIR)/
endif

ifdef TARGET_LIB
all: $(BUILD_DIR)/$(TARGET_LIB)
endif


# Update the archive rule to use full path
$(BUILD_DIR)/$(TARGET_LIB): $(OBJS)
	@mkdir -p $(dir $@)
	@mkdir -p $(BUILD_ROOT_LIB_DIR)
	@echo "Archiving: $@"
	@ar rcs $@ $^
	@cp $@ $(BUILD_ROOT_LIB_DIR)/
# 	@echo "Library created successfully!"

# Compile source files to object files
$(BUILD_DIR)/%.cpp.o: $(CURDIR)/%.cpp
	@mkdir -p $(dir $@)
	@echo "Compiling: $<"
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Compile source files to object files
$(BUILD_DIR)/%.c.o: $(CURDIR)/%.c
	@mkdir -p $(dir $@)
	@echo "Compiling: $<"
	@$(GCC) $(CXXFLAGS) -c $< -o $@

clean:
	@echo "Cleaning build directory..."
	rm -rf $(BUILD_DIR)


.PHONY: all
.DEFAULT_GOAL := all

debug:
	@echo "OBJS = $(OBJS)."
	@echo "TARGET_LIB = $(TARGET_LIB)."
	@echo "TARGET_LIBF = $(BUILD_DIR)/$(TARGET_LIB)."
	@echo "ROOT_DIR = $(ROOT_DIR)."
	@echo "BUILD_DIR = $(BUILD_DIR)."
	@echo "CURRENT_DIR = $(CURRENT_DIR)."
	@echo "SRCS = $(SRCS)."
	@echo "BUILD_ROOT_DIR = $(BUILD_ROOT_DIR)."
	@echo "BUILD_ROOT_OBJ_DIR = $(BUILD_ROOT_OBJ_DIR)."
	@echo "BUILD_ROOT_BIN_DIR = $(BUILD_ROOT_BIN_DIR)."
	@echo "BUILD_ROOT_LIB_DIR = $(BUILD_ROOT_LIB_DIR)."

-include $(DEPS)
