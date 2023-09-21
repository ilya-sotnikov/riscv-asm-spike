.include "regs.S"

.section .text

.globl main
main:
        addi sp, sp, -8
        sd ra, 0(sp)

        la a0, msg_sep
        jal print_str_ln

        la a0, msg_mtime
        jal print_str_ln
        li a0, MTIME_BASE
        ld a0, 0(a0)
        jal print_unsigned_ln
        la a0, msg_sep
        jal print_str_ln

        la a0, msg_c_fn
        jal print_str_ln
        jal c_function
        la a0, msg_sep
        jal print_str_ln

        la a0, msg_mtime
        jal print_str_ln
        li a0, MTIME_BASE
        ld a0, (a0)
        jal print_unsigned_ln
        la a0, msg_sep
        jal print_str_ln

        ld ra, 0(sp)
        addi sp, sp, 8

        li a0, 0
        j tohost_exit

.section .data

msg_mtime:    .asciz "mtime:"
msg_c_fn:     .asciz "calling a C function from asm:"
msg_sep:      .asciz "-------------------------"
