# Utils Library Makefile
# Demonstrates best practices for building a static library

# Library name (without lib prefix and .a extension)
LIBRARY_NAME = utils

# Compiler and flags
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++11 -O2 -fPIC

# Directories
BUILD_DIR = ../../build
OBJ_DIR = $(BUILD_DIR)/utils
LIB_DIR = $(BUILD_DIR)/lib

# Source files (automatically find all .cpp files)
SOURCES = $(wildcard *.cpp)
# Object files (replace .cpp with .o and add obj directory path)
OBJECTS = $(SOURCES:%.cpp=$(OBJ_DIR)/%.o)
# Target library
TARGET = $(LIB_DIR)/lib$(LIBRARY_NAME).a

# Default target
all: $(TARGET)

# Create the static library
$(TARGET): $(OBJECTS) | $(LIB_DIR)
	@echo "Creating static library: $@"
	ar rcs $@ $^
	@echo "Library created successfully!"

# Compile source files to object files
$(OBJ_DIR)/%.o: %.cpp | $(OBJ_DIR)
	@echo "Compiling: $<"
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Create necessary directories
$(OBJ_DIR):
	@echo "Creating directory: $@"
	mkdir -p $@

$(LIB_DIR):
	@echo "Creating directory: $@"
	mkdir -p $@

# Clean build artifacts
clean:
	@echo "Cleaning utils library build artifacts..."
	rm -rf $(OBJ_DIR)
	rm -f $(TARGET)

# Phony targets (targets that don't represent files)
.PHONY: all clean

# Print variables for debugging (useful during development)
debug:
	@echo "SOURCES: $(SOURCES)"
	@echo "OBJECTS: $(OBJECTS)"
	@echo "TARGET: $(TARGET)"
	@echo "CXX: $(CXX)"
	@echo "CXXFLAGS: $(CXXFLAGS)"



