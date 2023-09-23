.section .text

.include "regs.s"

trap_handler:
        .balign 4
        j trap_unimp_handler
        .balign 4
        j trap_unimp_handler
        .balign 4
        j trap_unimp_handler
        .balign 4
        j trap_unimp_handler
        .balign 4
        j trap_unimp_handler
        .balign 4
        j trap_unimp_handler
        .balign 4
        j trap_unimp_handler
        .balign 4
        j irq_mtimer_handler
        .balign 4
        j trap_unimp_handler
        .balign 4
        j trap_unimp_handler
        .balign 4
        j trap_unimp_handler
        .balign 4
        j trap_unimp_handler

trap_unimp_handler:
        ret

.globl trap_setup
trap_setup:
        addi sp, sp, -8
        sd ra, (sp)

        la t0, trap_handler
        csrw mtvec, t0

        li t0, MTVEC_VECTORED
        csrrs zero, mtvec, t0

        li t0, MSTATUS_MIE
        csrrs zero, mstatus, t0

        jal mtime_get

        li t2, 48000000
        add a0, a0, t2
        jal mtimecmp_set

        li t0, MIE_MTIE
        csrrs zero, mie, t0

        ld ra, (sp)
        addi sp, sp, 8

        ret

.globl irq_mtimer_handler
irq_mtimer_handler:
        la a0, msg_1s_passed
        jal print_str_ln

        la a0, msg_exit
        jal print_str_ln

        la a0, msg_sep
        jal print_str_ln

        li a0, 0
        j tohost_exit
        ret

.section .data

msg_1s_passed:    .asciz "1s has passed"
msg_exit:         .asciz "calling exit from irq_mtimer_handler"
