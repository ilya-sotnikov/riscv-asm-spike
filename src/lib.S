.section .text

# prints a char
# a0 char
# a0 printed char
.globl putc
putc:
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
.globl strlen
strlen:
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
.globl puts
puts:
        addi sp, sp, -24
        sd ra, 0(sp)
        sd s0, 8(sp)
        sd s1, 16(sp)

        mv s0, a0
        jal strlen
        mv a3, a0 # bytes to write
        mv s1, a0 # save string length for later

        mv a2, s0 # string
        li a0, 64 # sys_write
        li a1, 1 # stdout

        jal syscall

        li a0, '\n'
        jal putc

        mv a0, s1 # string length

        ld ra, 0(sp)
        ld s0, 8(sp)
        ld s1, 16(sp)
        addi sp, sp, 24
        ret

# prints a number as hex and a newline
# a0 number
# a0 printed string length
.globl puth
puth:
        addi sp, sp, -32
        sd ra, 24(sp)

        addi t0, sp, 16 # store hex digits and letters backwards
        sb zero, 1(sp) # null-termination for puts
        mv t1, a0
        j 1f # skip the first shift
.Lputh_loop:
        srli t1, t1, 4
        beqz t1, .Lputh_print
        addi t0, t0, -1 # decrement the store address
1:
        andi t2, t1, 0xF
        sltiu t3, t2, 0xA
        bnez t3, .Lputh_digit

.Lputh_letter:
        addi t2, t2, 'a' - 0xA
        j .Lputh_store
.Lputh_digit:
        addi t2, t2, '0'
.Lputh_store:
        sb t2, 0(t0)
        j .Lputh_loop

.Lputh_print:
        mv a0, t0
        jal puts

        ld ra, 24(sp)
        addi sp, sp, 32
        ret
