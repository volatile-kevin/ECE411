.align 4
.section .text
.globl _start
_start:
    # WB -> MEM forwarding test
    add x3, x1, 1 #2
    la x8, TEST
    sw  x3, 0(x8)
    lw  x4, TEST

    bne x4, x3, oof

HALT:
    beq x0, x0, HALT

.section .rodata
.balign 256 
CABBAGE:    .word 0x00CABBA6E
