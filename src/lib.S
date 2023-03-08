.section .text

# prints a char
# a0 char
# a0 written char
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
        addi sp, sp, -8
        sd ra, 0(sp)

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
        addi sp, sp, 8
        ret
