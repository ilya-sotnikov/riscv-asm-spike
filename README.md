# riscv-asm-spike

Bare metal RISC-V assembly examples for Spike (no pk)

## Structure

- src -- various examples written in assembly
- minimal -- minimal example (just terminate with exit code 0)

## Examples

- mtime
- interrupts (timer)
- exceptions
- calling a C function from asm
- calling an asm subroutine from C
- simple asm printing subroutines
- makefile

## Usage

To assemble, link and run:

`make run`
