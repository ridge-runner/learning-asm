# ONE SECOND SUM
# A program that increments a number repeatedly for one second.
#

# INPUTS: NONE
#

# PROCESS:
# * Figure out how to call a system timer.
#       - Linux syscall #
# * Set a register for counter.
# * Instruction: INCQ 
#

# OUTPUTS
# SUM of incremented values.
#

# INSTRUCTIONS, REGISTERS & VARIABLES
# RAX - Accumulator
# RCX - Counter
# SYSTEM TIMER - ??
# MAINLOOP: - program loop

#####################
#   START
#####################

.section .data
    flag: .byte 0

.section .bss
    sa_handler: .skip 8
    sa_flags: .skip 8
    sa_mask: .skip 8

    .lcomm rax_str, 20

.section .text

.globl _start

_start:
   
# Clear out the sa_mask
xorq %rdi, %rdi
movq %rdi, sa_mask

# Set up the sigaction structure
lea handler(%rip), %rdi
movq %rdi, sa_handler
movq $0, sa_flags

# Register the signal handler for SIGALARM (signal 14)
lea sa_handler(%rip), %rdi
xorq %rsi, %rsi
xorq %rdx, %rdx
movq $14, %rax
syscall

# Set the alarm for 1 second in the future
movq $37, %rax
movq $1, %rdi
syscall

loop:
    cmpb $0, flag(%rip)
    je continue
    jmp write 

continue:
    addq $1, %rax
    jmp loop

write: 
    # Convert rax to ASCII
    jmp dec_to_str
    
    # TODO: Write function

    jmp exit

dec_to_str:
    
    # TODO: Write conversion function
    ret

handler: 
    movb $1, flag(%rip)
    ret

exit:
    movq $0, %rdi
    movq $60, %rax
    syscall

