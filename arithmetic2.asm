# PURPOSE:  A simple program demonstrating simple arithmetic. 
#           Taken from Bartlett.
#           Alteration: Added the ability to take arguments from
#                       the command line.

# INPUT:    None.
#           Alteration: When called from CLI, the program will take
#                       one number (byte since the exit code only
#                       returns values between 0-255.
#

# OUTPUT:   Returns status code that is the result of arithmetic operation(s).
#           Result can be seen by calling "echo $?".

.globl _start

.section .data

.section .text

_start:
   # USING THE STACK TO GET ARGC FROM CLI #
    popq %rax # move argc to rax

    cmpq $2, %rax
    jl exit

    popq %rdi   # arg[0] - program name
    popq %rsi  # arg[1] - pointer to first argument stored to rsi

    # clear rax & rdx
    xorq %rax, %rax  # xor clears the bytes by comparing copies of the same 
    xorq %rdx, rdx   # register. If the bytes are set, then they eval to zero.
                     # 01110 rax
                     # 01110 rax
                     # 00000 xor is only true if one byte is set, false if both.

    
    # TODO: complete the conversion 
    #       To complete the conversion from ASCII to int. We look up the data value
    #       for '0', which is 48, and subtract it from the value stored in rsi's 
    #       memory reference. Since ASCII is a numerical value, the system will treat it as 
    #       a number, so we can test to see if the input is within a range (>= 48 < 58).
    #
    
exit: 
   # Set the exit system call number.
   movq $60, %rax   # move 60 to rax to set up syscall.

   # Perform the system call
    syscall
