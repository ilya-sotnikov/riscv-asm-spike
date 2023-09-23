.section .text

.include "regs.s"

# prints a char
# a0 char
# a0 printed char
.globl print_char
print_char:
        addi sp, sp, -9
        sd ra, 1(sp)

        sb a0, 0(sp)
        mv a2, sp # address of a char to write
        li a0, 64 # sys_write
        li a1, 1 # stdout
        li a3, 1 # 1 byte to write

        jal syscall

        lb a0, 0(sp)

        ld ra, 1(sp)
        addi sp, sp, 9
        ret

# returns the length of a null-terminated string
# a0 string
# a0 string length
.globl str_len
str_len:
        mv t0, a0
1:
        lb t1, 0(a0)
        beqz t1, 2f
        addi a0, a0, 1
        j 1b
2:
        sub a0, a0, t0 # len = mem_end - mem_start

        ret

# prints a null-terminated string and a newline
# a0 string
# a0 string length
.globl print_str_ln
print_str_ln:
        addi sp, sp, -24
        sd ra, 0(sp)
        sd s0, 8(sp)
        sd s1, 16(sp)

        mv s0, a0
        jal str_len
        mv a3, a0 # bytes to write
        mv s1, a0 # save string length for later

        mv a2, s0 # string
        li a0, 64 # sys_write
        li a1, 1 # stdout

        jal syscall

        li a0, '\n'
        jal print_char

        mv a0, s1 # string length

        ld ra, 0(sp)
        ld s0, 8(sp)
        ld s1, 16(sp)
        addi sp, sp, 24
        ret

# prints a number as hex and a newline
# a0 number
# a0 printed string length
.globl print_hex_ln
print_hex_ln:
        addi sp, sp, -32

        sd ra, 24(sp)

        addi t0, sp, 15 # store hex digits and letters backwards
        sb zero, 1(t0) # null-termination for print_str_ln
        mv t1, a0
        j 1f # skip the first shift
.Lprint_hex_ln_loop:
        srli t1, t1, 4
        beqz t1, .Lprint_hex_ln_print
        addi t0, t0, -1 # decrement the store address
1:
        andi t2, t1, 0xF
        sltiu t3, t2, 0xA
        bnez t3, .Lprint_hex_ln_digit

.Lprint_hex_ln_letter:
        addi t2, t2, 'a' - 0xA
        j .Lprint_hex_ln_store
.Lprint_hex_ln_digit:
        addi t2, t2, '0'
.Lprint_hex_ln_store:
        sb t2, 0(t0)
        j .Lprint_hex_ln_loop

.Lprint_hex_ln_print:
        mv a0, t0
        jal print_str_ln

        ld ra, 24(sp)
        addi sp, sp, 32
        ret

# prints an unsigned number and a newline
# a0 number
# a0 printed string length
.globl print_unsigned_ln
print_unsigned_ln:
        addi sp, sp, -32
        sd ra, 24(sp)

        addi t0, sp, 19 # storing backwards, max digits log10(2^64)+1
        sb zero, 1(t0) # null-termination

        li t6, 10

.Lprint_unsigned_ln_loop:
        remu t1, a0, t6

        addi t1, t1, '0'
        sb t1, (t0)

        bltu a0, t6, .Lprint_unsigned_ln_print

        addi t0, t0, -1
        divu a0, a0, t6
        j .Lprint_unsigned_ln_loop

.Lprint_unsigned_ln_print:
        mv a0, t0
        jal print_str_ln

        ld ra, 24(sp)
        addi sp, sp, 32
        ret

# prints a signed number and a newline
# a0 number
# a0 printed string length
.globl print_signed_ln
print_signed_ln:
        addi sp, sp, -16
        sd ra, (sp)

        bgtz a0, 1f

        sd a0, 8(sp)
        li a0, '-'
        jal print_char
        ld a0, 8(sp)

        neg a0, a0
1:
        jal print_unsigned_ln

        ld ra, (sp)
        addi sp, sp, 16

        ret

# a0 mtime
.globl mtime_get
mtime_get:
        li a0, MTIME_BASE
        ld a0, (a0)
        ret

# a0 new_value
.globl mtimecmp_set
mtimecmp_set:
        li t0, MTIMECMP_BASE
        sd a0, (t0)
        ret
