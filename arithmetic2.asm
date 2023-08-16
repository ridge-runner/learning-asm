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

    cmpq $2, %rax # Tests to see if we have a value >= 2 in argc.
    jl exit

    # Cycle through the stack values down to the one we need. Arguments passed from 
    # the CLI start with the program name argc[0], then each value in order. Their default type is 
    # ASCII strings (or UTF, but I haven't studied this yet.) So, the number 5 passed
    # through the CLI will actually be 53 (ASCII '0' = 48, 48 + 5 = 53).
    
    xorq %rdi, %rdi # clear reg
    xorq %rsi, %rsi # clear reg

    popq %rdi   # arg[0] - pop off the program name to rdi
    popq %rsi   # arg[1] - popp off pointer to first argument to rsi

    # clear junk out of rax & rdx
    xorq %rax, %rax  # xor clears the bytes by comparing copies of the same 
                     # register. If the bytes are set, then they eval to zero.
                     # 01110 rax
                     # 01110 rax
                     # 00000 xor is only true if one byte is set, false if both.

    
    # TODO: complete the conversion 
    #       To complete the conversion from ASCII to int. We look up the data value
    #       for '0', which is 48, and subtract it from the value stored in rsi's 
    #       memory reference. Since ASCII is a numerical value, the system will treat it as 
    #       a number, so we can test to see if the input is within a range (>= 48 < 58).
    #
    
    # Dereference rsi so we can use the value it points to low byte of the accumulator.
    movb (%rsi), %al


    # test input to make sure that it is between ASCII 0 - 9
    cmpb $48, %al
    jl bad_input

    cmpb $57, %al
    jg bad_input

    # convert string to number
    sub $48, %al

    # Now we have a converted number from string to quadword

    # Now we test to make sure that the output is correct before we begin 
    # working with the value. We clear rdi before moving the value to it.

    movb %al, %dil  # move value to rdi so can echo it out to error on CLI.

bad_input:
    # movzbl - move zero-extend byte-to-long - fills the extra space in %edi
    # with zeros to prevent junk from messing with our result.
    movzbl %al, %edi
    jmp exit
    
exit: 
   # Set the exit system call number.
   movq $60, %rax   # move 60 to rax to set up syscall.

   # Perform the system call
    syscall
