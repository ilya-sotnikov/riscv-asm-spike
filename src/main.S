.section .text

.globl main
main:
        la a0, msg
        jal puts

        li a0, 0
        j tohost_exit

.section .data

msg: .asciz "testing output"
