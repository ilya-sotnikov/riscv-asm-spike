.section ".text.init", "ax", @progbits

.globl _start
_start:
        la sp, _sstack

        j main
