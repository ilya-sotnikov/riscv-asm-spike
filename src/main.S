.include "regs.S"

.section .text

.globl main
main:
        addi sp, sp, -8
        sd ra, 0(sp)

        la a0, msg_sep
        jal print_str_ln
        la a0, msg_out
        jal print_str_ln
        la a0, msg_sep
        jal print_str_ln

        la a0, msg_hex
        jal print_str_ln
        li a0, -1
        jal print_hex_ln
        jal print_hex_ln # length of the printed hex number, should be 0x10
        li a0, 0xDEADC0DED15EA5ED
        jal print_hex_ln
        la a0, msg_sep
        jal print_str_ln


        la a0, msg_unsigned
        jal print_str_ln
        li a0, 1337
        jal print_unsigned_ln
        li a0, 0xffffffffffffffff
        jal print_unsigned_ln
        la a0, msg_sep
        jal print_str_ln

        la a0, msg_mtime
        jal print_str_ln
        li a0, MTIME_BASE
        ld a0, 0(a0)
        jal print_unsigned_ln
        la a0, msg_sep
        jal print_str_ln

        la a0, msg_signed
        jal print_str_ln
        li a0, 1337
        jal print_signed_ln
        li a0, -1
        jal print_signed_ln
        li a0, -258
        jal print_signed_ln
        li a0, 0xffffffffffffffff
        jal print_signed_ln
        li a0, 0x8000000000000000
        jal print_signed_ln
        li a0, 0x7fffffffffffffff
        jal print_signed_ln
        la a0, msg_sep
        jal print_str_ln

        la a0, msg_mtime
        jal print_str_ln
        li a0, MTIME_BASE
        ld a0, (a0)
        jal print_unsigned_ln
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

msg_out:      .asciz "testing output"
msg_hex:      .asciz "testing hex"
msg_unsigned: .asciz "testing unsigned"
msg_signed:   .asciz "testing signed"
msg_mtime:    .asciz "mtime:"
msg_sep:      .asciz "-------------------------"
