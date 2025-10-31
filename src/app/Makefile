# Application Makefile
# Demonstrates best practices for building an executable that links with libraries

# Application name
APP_NAME = demo_app

# Compiler and flags
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++11 -O2
LDFLAGS = -L../../build/lib
LDLIBS = -lmath -lutils

# Directories
BUILD_DIR = ../../build
OBJ_DIR = $(BUILD_DIR)/app
BIN_DIR = $(BUILD_DIR)/bin
LIB_DIR = $(BUILD_DIR)/lib

# Source files (automatically find all .cpp files)
SOURCES = $(wildcard *.cpp)
# Object files (replace .cpp with .o and add obj directory path)
OBJECTS = $(SOURCES:%.cpp=$(OBJ_DIR)/%.o)
# Target executable
TARGET = $(BIN_DIR)/$(APP_NAME)

# Library dependencies (the libraries this app links against)
LIBS = $(LIB_DIR)/libmath.a $(LIB_DIR)/libutils.a

# Default target
all: $(TARGET)

# Create the executable
$(TARGET): $(OBJECTS) $(LIBS) | $(BIN_DIR)
	@echo "Linking executable: $@"
	$(CXX) $(OBJECTS) $(LDFLAGS) $(LDLIBS) -o $@
	@echo "Executable created successfully!"

# Compile source files to object files
$(OBJ_DIR)/%.o: %.cpp | $(OBJ_DIR)
	@echo "Compiling: $<"
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Build required libraries (calls make in library directories)
$(LIB_DIR)/libmath.a:
	@echo "Building math library..."
	$(MAKE) -C ../math

$(LIB_DIR)/libutils.a:
	@echo "Building utils library..."
	$(MAKE) -C ../utils

# Create necessary directories
$(OBJ_DIR):
	@echo "Creating directory: $@"
	mkdir -p $@

$(BIN_DIR):
	@echo "Creating directory: $@"
	mkdir -p $@

# Clean build artifacts
clean:
	@echo "Cleaning application build artifacts..."
	rm -rf $(OBJ_DIR)
	rm -f $(TARGET)

# Clean everything including libraries
clean-all: clean
	@echo "Cleaning all dependencies..."
	$(MAKE) -C ../math clean
	$(MAKE) -C ../utils clean

# Run the application
run: $(TARGET)
	@echo "Running $(APP_NAME)..."
	@echo "========================"
	$(TARGET)

# Phony targets (targets that don't represent files)
.PHONY: all clean clean-all run

# Print variables for debugging (useful during development)
debug:
	@echo "SOURCES: $(SOURCES)"
	@echo "OBJECTS: $(OBJECTS)"
	@echo "TARGET: $(TARGET)"
	@echo "LIBS: $(LIBS)"
	@echo "CXX: $(CXX)"
	@echo "CXXFLAGS: $(CXXFLAGS)"
	@echo "LDFLAGS: $(LDFLAGS)"
	@echo "LDLIBS: $(LDLIBS)"



