.PHONY: all clean run

TOOLCHAIN_PREFIX := riscv64-elf
AS := $(TOOLCHAIN_PREFIX)-as
CC := $(TOOLCHAIN_PREFIX)-gcc
LD := $(TOOLCHAIN_PREFIX)-ld

SRC_DIR := src
TARGET_DIR := target

SRC := $(wildcard $(SRC_DIR)/*.s $(SRC_DIR)/*.c)
OBJ := $(filter %.o, $(SRC:$(SRC_DIR)/%.s=$(TARGET_DIR)/%.o) \
	   $(SRC:$(SRC_DIR)/%.c=$(TARGET_DIR)/%.o))

TARGET_NAME := main
LINKER_SCRIPT := riscv.ld

AS_FLAGS := -march=rv64gc
LD_FLAGS := -Map=$(TARGET_DIR)/$(TARGET_NAME).map -T $(SRC_DIR)/$(LINKER_SCRIPT)
C_FLAGS := -Wall -Wextra -std=c11 -pedantic -O2 -ffreestanding -nostdlib -mcmodel=medany -c

all: $(TARGET_DIR)/$(TARGET_NAME)

$(TARGET_DIR)/$(TARGET_NAME): $(OBJ)
	$(LD) $(LD_FLAGS) -o $@ $^

$(TARGET_DIR)/%.o: $(SRC_DIR)/%.s
	mkdir -p $(TARGET_DIR)
	$(AS) $(AS_FLAGS) -I $(SRC_DIR) -o $@ $<

$(TARGET_DIR)/%.o: $(SRC_DIR)/%.c
	mkdir -p $(TARGET_DIR)
	$(CC) $(C_FLAGS) -o $@ $<

clean:
	rm -rf $(TARGET_DIR)

run: all
	spike $(TARGET_DIR)/$(TARGET_NAME)
