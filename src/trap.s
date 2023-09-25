.section .text

.include "regs.s"
.include "macro.s"

trap_entry:
        .balign 4
        j exception_handler
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

exception_handler:
        SAVE_REGS

        la a0, msg_mcause
        jal print_str_ln

        csrr a0, mcause
        slli a0, a0, 1
        srli a0, a0, 1
        jal print_unsigned_ln

        la a0, msg_sep
        jal print_str_ln

        csrr a0, mepc
        addi a0, a0, 2
        csrw mepc, a0

        RESTORE_REGS

        mret

trap_unimp_handler:
        SAVE_REGS

        la a0, msg_unimp
        jal print_str_ln

        csrr a0, mcause
        slli a0, a0, 1
        srli a0, a0, 1
        jal print_unsigned_ln

        la a0, msg_sep
        jal print_str_ln

        li a0, 1
        j tohost_exit

        RESTORE_REGS

        mret

.globl trap_setup
trap_setup:
        addi sp, sp, -8
        sd ra, (sp)

        la t0, trap_entry
        csrw mtvec, t0

        li t0, MTVEC_VECTORED
        csrrs zero, mtvec, t0

        li t0, MSTATUS_MIE
        csrrs zero, mstatus, t0

        jal mtime_get

        li t2, MTIMER_FREQ
        add a0, a0, t2
        jal mtimecmp_set

        li t0, MIE_MTIE
        csrrs zero, mie, t0

        ld ra, (sp)
        addi sp, sp, 8

        ret

.globl irq_mtimer_handler
irq_mtimer_handler:
        SAVE_REGS

        la a0, msg_1s_passed
        jal print_str_ln

        jal mtime_get

        li t2, MTIMER_FREQ
        add a0, a0, t2
        jal mtimecmp_set

        la t0, irq_mtimer_cnt
        lb a0, (t0)
        addi a0, a0, 1
        sb a0, (t0)

        li t0, 3
        blt a0, t0, 1f

        la a0, msg_exit
        jal print_str_ln

        la a0, msg_sep
        jal print_str_ln

        li a0, 0
        j tohost_exit

1:
        RESTORE_REGS

        mret

.section .data

msg_1s_passed:    .asciz "1s has passed"
msg_exit:         .asciz "calling exit from irq_mtimer_handler"
msg_mcause:       .asciz "mcause:"
msg_unimp:        .asciz "trap_unimp_handler, mcause:"
irq_mtimer_cnt:   .byte 0
