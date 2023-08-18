# FOLLOW THE JUMP
# The program has several jumps. Follow the jumps to see the output value.

.globl _start

.section .data
	# None

.section .text

_start:
	movq $25, %rax
	jmp thelabel

somewhere:
	movq %rax, %rdi  # movq clobbers existing values.
    jmp anotherlabel

label1:
    addq %rbx, %rax
    movq $5, %rbx
    jmp here

labellabel:
    syscall

anotherlabel:
    movq $60, %rax
    jmp labellabel

thelabel:
    movq %rax, %rbx
    jmp there

here:
    # divq takes a divisor (mem addr) and divides 
    # rdx:rax. Remainder stores to rdx; quotient stores to rax.
    # The operation clobbers any existing values stored in those registers.
    divq %rbx
    jmp somewhere

there:
    addq $5, %rbx
    jmp label1

anywhere:
    jmp thelabel


