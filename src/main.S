.section .text

.globl main
main:
        addi sp, sp, -8
        sd ra, 0(sp)

        la a0, msg
        jal print_str_ln

        li a0, -1
        jal print_hex_ln
        jal print_hex_ln # length of the printed hex number, should be 0x10

        li a0, 1337
        jal print_hex_ln

        ld ra, 0(sp)
        addi sp, sp, 8

        li a0, 0
        j tohost_exit

.section .data

msg: .asciz "testing output"
