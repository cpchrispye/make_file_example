include Include.mk

PROJECT_ROOT := $(CURDIR)
export PROJECT_ROOT

# Subdirectories containing components to build
SUBDIRS := src/math src/utils
APPDIRS := src/app

# Default target - build everything
all: app


libs: ${SUBDIRS}
${SUBDIRS}:
	echo "Building lib ${$@}..."; 
	@$(MAKE) -C $@ 


# Build the main application (which depends on libraries)
app: ${APPDIRS} | libs
	@echo "Building application..."
	$(MAKE) -C $^
	@echo "Application built successfully!"

clean:
	@echo "Cleaning build directory..."
	rm -rf build

.PHONY: ${SUBDIRS}



