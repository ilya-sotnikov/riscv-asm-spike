OUTPUT_ARCH("riscv")

ENTRY(_start)

SECTIONS
{
    . = 0x80000000;

    .tohost : ALIGN(0x1000)
    {
        *(.tohost)
    }

    . += 0x1000;

    .text : ALIGN(0x1000)
    {
        *(.text)
    }
}
