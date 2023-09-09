.PHONY: all clean run

TOOLCHAIN_PREFIX := riscv64-elf
AS := $(TOOLCHAIN_PREFIX)-as
CC := $(TOOLCHAIN_PREFIX)-gcc
LD := $(TOOLCHAIN_PREFIX)-ld

SRC_DIR := src
TARGET_DIR := target

SRC := $(wildcard $(SRC_DIR)/*.S $(SRC_DIR)/*.c)
OBJ := $(filter %.o, $(SRC:$(SRC_DIR)/%.S=$(TARGET_DIR)/%.o) \
	   $(SRC:$(SRC_DIR)/%.c=$(TARGET_DIR)/%.o))

TARGET_NAME := main
LINKER_SCRIPT := riscv.ld

LD_FLAGS := -Map=$(TARGET_DIR)/$(TARGET_NAME).map -T $(SRC_DIR)/$(LINKER_SCRIPT)

all: $(TARGET_DIR)/$(TARGET_NAME)

$(TARGET_DIR)/$(TARGET_NAME): $(OBJ)
	$(LD) $(LD_FLAGS) -o $@ $^

$(TARGET_DIR)/%.o: $(SRC_DIR)/%.S
	mkdir -p $(TARGET_DIR)
	$(AS) -o $@ $<

$(TARGET_DIR)/%.o: $(SRC_DIR)/%.c
	mkdir -p $(TARGET_DIR)
	$(CC) -Wall -Werror -Og -ggdb -ffreestanding -nostdlib -r -o $@ $<

clean:
	rm -rf $(TARGET_DIR)

run: all
	spike $(TARGET_DIR)/$(TARGET_NAME)
