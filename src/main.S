.section .text

.globl main
main:
        addi sp, sp, -8
        sd ra, 0(sp)

        la a0, msg
        jal puts

        li a0, -1
        jal puth
        jal puth # length of the printed hex number, should be 0x10

        li a0, 1337
        jal puth

        ld ra, 0(sp)
        addi sp, sp, 8

        li a0, 0
        j tohost_exit

.section .data

msg: .asciz "testing output"
