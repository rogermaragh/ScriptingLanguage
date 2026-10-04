BUILD_DIR ?= build
CMAKE ?= cmake
CLANG ?= clang
CMAKE_FLAGS ?= -DCMAKE_BUILD_TYPE=Debug

.PHONY: all rat clean compile

all:
	@$(CMAKE) -S . -B "$(BUILD_DIR)" $(CMAKE_FLAGS)
	@$(CMAKE) --build "$(BUILD_DIR)"

rat: all
	@cd "$(BUILD_DIR)" && ./rat

clean:
	@$(CMAKE) --build "$(BUILD_DIR)" --target clean

compile: rat
	@$(CLANG) "$(BUILD_DIR)/data/compile.ll" -o "$(BUILD_DIR)/compile"
	@"$(BUILD_DIR)/compile"

