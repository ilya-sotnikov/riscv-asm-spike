.equ CLINT_BASE,        0x02000000

.equ MTIMECMP_BASE,     CLINT_BASE + 0x00004000
.equ MTIME_BASE,        CLINT_BASE + 0x0000bff8

.equ MSTATUS_MIE,       1 << 3

.equ MIE_MTIE,          1 << 7

.equ MTVEC_DIRECT,      0
.equ MTVEC_VECTORED,    1

.equ MTIMER_FREQ,       48000000    # idk
