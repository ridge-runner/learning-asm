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
# none

.section .text

.globl _start   

.type _start, @function

_start:
   
    # Clear registers
    xorq %rax, %rax
    xorq %rdi, %rdi

 # syscall: Alarm ID Rax(37), rdi(sec)
    movq $37, %rax
    movq $1, %rdi
    syscall

 # Register signal handler for alarm
 # rt_sigaction rax13, rdi(act), rsi(oact), rdx(sigsetsize)
    xor %rsi, %rsi          ; clear registers
    xor %rdx, %rdx          

    movq $14, %rax          ; Syscall number
    lea handler(%rip), %rdi ; addr of signal handler
    syscall    
    
   # Loop to increment RAX
loop:   
    add $1, %rax
    jmp loop

handler:
    # exit syscall
    mov $60, %rax
    xor %rdi, %rdi
    syscall


exit:

    movq $60, rax
    syscall

