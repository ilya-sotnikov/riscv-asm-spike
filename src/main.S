.section .text

.global _start

_start:
        li a0, 0
        j tohost_exit

        1: j 1b

tohost_exit:
        slli a0, a0, 1
        ori a0, a0, 1

        la t0, tohost
        sd a0, 0(t0)

        1: j 1b
