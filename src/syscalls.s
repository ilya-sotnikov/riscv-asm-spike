.section .text

.globl tohost_exit
tohost_exit:
        slli a0, a0, 1
        ori a0, a0, 1

        la t0, tohost
        sd a0, 0(t0)

        1: j 1b

# performs a system call
# a0 which
# a1 arg0
# a2 arg1
# a3 arg2
# a0 syscall number
.globl syscall
syscall:
        la t0, magic_mem
        sd a0, 8*0(t0)
        sd a1, 8*1(t0)
        sd a2, 8*2(t0)
        sd a3, 8*3(t0)

        fence

        la t1, tohost
        sd t0, 0(t1)

        la t1, fromhost
1:
        ld t2, 0(t1)
        beqz t2, 1b # wait until the host executes the specified syscall

        sd zero, 0(t1)

        fence

        ret # syscall number in a0

# to communicate with the host
# check riscv-software-src/riscv-tests
.section .tohost, "aw", @progbits

.align 6
.globl tohost
tohost: .dword 0

.align 6
.globl fromhost
fromhost: .dword 0

# a syscall buffer
.align 6
magic_mem: .dword 0, 0, 0, 0, 0, 0, 0, 0
