.PHONY: all clean run

SRC_DIR := src
TARGET_DIR := target

SRC := $(wildcard $(SRC_DIR)/*.S)
OBJ := $(patsubst $(SRC_DIR)/%.S, $(TARGET_DIR)/%.o, $(SRC))

TARGET_NAME := main
LINKER_SCRIPT := riscv.ld

LD_FLAGS := -Map=$(TARGET_DIR)/$(TARGET_NAME).map -T $(SRC_DIR)/$(LINKER_SCRIPT)

all: $(TARGET_DIR)/$(TARGET_NAME)

$(TARGET_DIR)/$(TARGET_NAME): $(OBJ)
	riscv64-unknown-elf-ld $(LD_FLAGS) -o $@ $^

$(TARGET_DIR)/%.o: $(SRC_DIR)/%.S
	mkdir -p $(TARGET_DIR)
	riscv64-unknown-elf-as -o $@ $<

clean:
	rm -rf $(TARGET_DIR)

run: all
	spike $(TARGET_DIR)/$(TARGET_NAME)
