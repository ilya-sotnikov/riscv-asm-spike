OUTPUT_ARCH("riscv")

ENTRY(_start)

SECTIONS
{
    . = 0x80000000;

    .tohost : ALIGN(4K)
    {
        *(.tohost)
    }

    . += 4K;

    .text : ALIGN(4K)
    {
        *(.text)
        *(.text.init)
    }

    .data : ALIGN(4K)
    {
        *(.data)
    }

    .stack : ALIGN(4K)
    {
        _estack = .;
        . += 128K;
        _sstack = .;
    }

}
