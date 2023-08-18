# CALCULATE EXPONENTS
# An exercise with loops

.globl _start

# This program calculates 2^3
# You can modify %rbx & % rcx to calculate
# another exponential.

.section .data
    # none

.section .text
_start:
    movq $2, %rbx
    movq $3, %rcx
    movq $1, %rax

mainloop:
    addq $0, %rcx

    jz complete

    mulq %rbx

    decq %rcx

    jmp mainloop

complete:
    movq %rax, %rdi

    movq $60, %rax
    syscall
