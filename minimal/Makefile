.PHONY: all clean run

all:
	riscv64-unknown-elf-as -o main.o main.S
	riscv64-unknown-elf-ld -Map=main.map -T riscv.ld -o main main.o

clean:
	rm *.o *.map main

run: all
	spike main
