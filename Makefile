# Top-Level Makefile for C++ Make Demo Project
# Demonstrates best practices for orchestrating a multi-component build

# Project configuration
PROJECT_NAME = cpp_make_demo
BUILD_DIR = build

# Compiler and flags (can be overridden from command line)
CXX ?= g++
CXXFLAGS ?= -Wall -Wextra -std=c++11 -O2

# Export variables to sub-makes
export CXX
export CXXFLAGS

# Subdirectories containing components to build
SUBDIRS = src/math src/utils src/app

# Default target - build everything
all: libs app

# Build all libraries
libs:
	@echo "Building all libraries..."
	$(MAKE) -C src/math
	$(MAKE) -C src/utils
	@echo "All libraries built successfully!"

# Build the main application (which depends on libraries)
app: libs
	@echo "Building application..."
	$(MAKE) -C src/app
	@echo "Application built successfully!"

# Install target (copies executable to a standard location)
install: app
	@echo "Installing $(PROJECT_NAME)..."
	mkdir -p /usr/local/bin
	cp $(BUILD_DIR)/bin/demo_app /usr/local/bin/$(PROJECT_NAME)
	@echo "Installation complete! Run with: $(PROJECT_NAME)"

# Run the demo application
run: app
	@echo "Running $(PROJECT_NAME) demo..."
	@echo "================================="
	$(BUILD_DIR)/bin/demo_app

# Test target (placeholder for actual tests)
test: app
	@echo "Running tests..."
	@echo "Note: In a real project, you would run unit tests here"
	@echo "For now, we'll just run the demo to verify it works:"
	@echo "================================="
	$(BUILD_DIR)/bin/demo_app
	@echo "================================="
	@echo "If you saw output above, the test passed!"

# Clean individual components
clean-math:
	$(MAKE) -C src/math clean

clean-utils:
	$(MAKE) -C src/utils clean

clean-app:
	$(MAKE) -C src/app clean

# Clean all build artifacts
clean: clean-math clean-utils clean-app
	@echo "Cleaning top-level build directory..."
	rm -rf $(BUILD_DIR)
	@echo "Clean complete!"

# Rebuild everything from scratch
rebuild: clean all

# Create build directory structure
$(BUILD_DIR):
	@echo "Creating build directory structure..."
	mkdir -p $(BUILD_DIR)/lib
	mkdir -p $(BUILD_DIR)/bin
	mkdir -p $(BUILD_DIR)/math
	mkdir -p $(BUILD_DIR)/utils
	mkdir -p $(BUILD_DIR)/app

# Help target - shows available commands
help:
	@echo "Available targets:"
	@echo "  all       - Build everything (default)"
	@echo "  libs      - Build all libraries"
	@echo "  app       - Build the application"
	@echo "  run       - Build and run the demo application"
	@echo "  test      - Run tests (currently just runs the demo)"
	@echo "  install   - Install the application to /usr/local/bin"
	@echo "  clean     - Remove all build artifacts"
	@echo "  rebuild   - Clean and build everything"
	@echo "  help      - Show this help message"
	@echo ""
	@echo "Component-specific clean targets:"
	@echo "  clean-math  - Clean math library only"
	@echo "  clean-utils - Clean utils library only"  
	@echo "  clean-app   - Clean application only"
	@echo ""
	@echo "Debug targets:"
	@echo "  debug     - Show build configuration"
	@echo ""
	@echo "Override variables:"
	@echo "  CXX       - Compiler (default: g++)"
	@echo "  CXXFLAGS  - Compiler flags (default: -Wall -Wextra -std=c++11 -O2)"
	@echo ""
	@echo "Examples:"
	@echo "  make                    # Build everything"
	@echo "  make run                # Build and run"
	@echo "  make CXX=clang++        # Use clang++ instead of g++"
	@echo "  make CXXFLAGS=\"-g -O0\"   # Debug build"

# Debug target - shows configuration
debug:
	@echo "Build Configuration:"
	@echo "  PROJECT_NAME: $(PROJECT_NAME)"
	@echo "  BUILD_DIR:    $(BUILD_DIR)"
	@echo "  CXX:          $(CXX)"
	@echo "  CXXFLAGS:     $(CXXFLAGS)"
	@echo "  SUBDIRS:      $(SUBDIRS)"
	@echo ""
	@echo "Directory structure:"
	@find . -type d | head -20

# Phony targets (targets that don't represent files)
.PHONY: all libs app install run test clean clean-math clean-utils clean-app rebuild help debug

# Default target when no target is specified
.DEFAULT_GOAL := all



