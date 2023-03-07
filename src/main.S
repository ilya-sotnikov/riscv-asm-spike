.section .text

.globl main

main:
        addi sp, sp, -8

        li a0, 64 # sys_write
        li a1, 1 # stdout

        li t0, 0x0a74736574  # "test\n"
        sd t0, 0(sp)
        mv a2, sp # address of "test\n"

        li a3, 5 # bytes count to write

        jal syscall

        addi sp, sp, 8

        li a0, 0
        j tohost_exit
