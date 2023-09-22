.section ".text.init", "ax", @progbits

.include "regs.S"

.globl _start
_start:
        la sp, _sstack

        jal trap_setup

        j main

        li a0, 0
        j tohost_exit
