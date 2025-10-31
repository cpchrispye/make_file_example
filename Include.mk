MAKEFILE_PATH := $(lastword $(MAKEFILE_LIST))
ROOT_DIR := $(dir $(abspath $(MAKEFILE_PATH)))


CXX ?= g++
CXXFLAGS ?= -Wall -Wextra -std=c++11 -O2 -MMD -MP
# Project configuration
PROJECT_NAME = cpp_make_demo
BUILD_DIR = $(ROOT_DIR)/build

# OBJ_DIR = $(BUILD_DIR)/app
# BIN_DIR = $(BUILD_DIR)/bin
# LIB_DIR = $(BUILD_DIR)/lib

OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

.PHONY: all
.DEFAULT_GOAL := all

$(BUILD_DIR):
	@echo "Creating build directory structure..."
	mkdir -p $(BUILD_DIR)


ifdef TARGET
all: $(BUILD_DIR)/$(TARGET)
endif

ifdef LIB
all: $(BUILD_DIR)/$(LIB)
endif

$(BUILD_DIR)/$(TARGET): $(OBJS) | $(BUILD_DIR)

	@echo "Compiling Target: $<"
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/$(LIB): $(OBJS) | $(BUILD_DIR)
	@echo "Archiving : $@"
	ar rcs $@ $^
	@echo "Archiving created successfully!"

# Compile source files to object files
$(BUILD_DIR)/%.cpp.o: %.cpp | $(BUILD_DIR)
	@echo "Compiling: $<"
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/%.c.o: %.cpp | $(BUILD_DIR)
	@echo "Compiling: $<"
	$(GCC) $(CXXFLAGS) -c $< -o $@

clean:
	@echo "Cleaning build directory..."
	rm -rf $(BUILD_DIR)

-include $(DEPS)