# ONE SECOND SUM
# A program that increments a number repeatedly for one second.
#

# INPUTS: NONE
#   

# OUTPUTS
# SUM of incremented values to stdout.
#

# PROCESS:
# * Use the Alarm syscall to generate a 
#   signal that will end the loop.
# * Use the accumulator (rax) to track loops.
# * Convert numerical value to ascii.
# * Write sum to stdout.
# *


# INSTRUCTIONS, REGISTERS & VARIABLES
# Alarm syscall - SIGALARM
# signal handler - sa_handler
# Write syscall
# write to stdout.
#

#####################
#   START
#####################

.section .data
    flag: .byte 0 # for the handler to break the loop.

.section .bss
    sa_handler: .skip 8 # reserve quadword
    sa_flags: .skip 8
    sa_mask: .skip 8

    .lcomm str_array, 20 # reserve buffer for 8B number.

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
    jmp dec_to_str

continue:
    addq $1, %rax
    jmp loop

dec_to_str:
    # set up
    xorq %rdi, %rdi # clear index
    
    # load str array address (name) to rdi
    lea -1(str_array+19), %rdi # load array addr to rdi
    movb $0, (%rdi) # null terminate the string
    
convert_loop:
    # rax contains the incremented value.
    dec %rdi        # move index -1
    xor %rdx, %rdx  # delete remainder
    divq $10        # divid rax by ten, rdx takes remainder
    addb $'0', %dl  # convert remainder to ASCII (add 48) to low bytes of rdx
    movb %dl, (%rdx) # store ASCII character




    # To convert decimal values to ASCII,
    # We first loop over the value dividing
    # by 10. Then to convert to ASCII, we add
    # 48 (ASCII '0') to each number.


write: 
    
    # TODO: Write function

    jmp exit

handler: 
    movb $1, flag(%rip)
    ret

exit:
    movq $0, %rdi
    movq $60, %rax
    syscall

