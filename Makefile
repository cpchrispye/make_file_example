include Include.mk


# Subdirectories containing components to build
SUBDIRS := src/math src/utils
APPDIRS := src/app

# Default target - build everything
all: app


libs: ${SUBDIRS}
${SUBDIRS}:
	echo "Building lib ${$@}..."; 
	$(MAKE) -C $@ 


# Build the main application (which depends on libraries)
app: ${APPDIRS} | libs
	@echo "Building application..."
	$(MAKE) -C $^
	@echo "Application built successfully!"


# Clean all build artifacts
clean: 
	@echo "Cleaning top-level build directory..."
	rm -rf $(BUILD_DIR)
	@echo "Clean complete!"

# Rebuild everything from scratch
rebuild: clean all


# Phony targets (targets that don't represent files)
.PHONY: all libs app clean ${SUBDIRS}



