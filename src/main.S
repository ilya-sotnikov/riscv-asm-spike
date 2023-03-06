.section .text

.globl _start

_start:
        li a0, 64
        li a1, 1
        la a2, msg
        li a3, 5
        jal syscall

        li a0, 0
        j tohost_exit

        1: j 1b

.section .data
msg: .asciz "test\n"
