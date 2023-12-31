# PURPOSE:  A simple program demonstrating simple arithmetic. 
#           Taken from Bartlett.
#           Alteration: Added the ability to take single argument from
#                       the command line.

# INPUT:    Program takes one argument on the CLI of 0-9. 
#           

# OUTPUT:   Returns status code that is the result of arithmetic operation(s).
#           If the input was an even number, half of the value is returned.
#           If the inputs was an odd number, the remainder is returned.
#           Result can be seen by calling "echo $?".

# VARIABLES: 
#           rdi: returns value
#           ah: holds remainder
#           al: holds quotient
#           divisor: holds divisor
#           


.globl _start

.section .data

    divisor:
        .byte 2

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

    # clear junk out of rax & ax
    xorq %rax, %rax  # xor clears the bytes by comparing copies of the same 
    xorw %ax, %ax    # register. If the bytes are set, then they eval to zero.
                     # 01110 rax
                     # 01110 rax
                     # 00000 xor is only true if one byte is set, false if both.

    
    # Dereference rsi so we can use the value it points to low byte of the accumulator.
    movb (%rsi), %cl

    # test input to make sure that it is between ASCII 0 - 9
    cmpb $48, %cl
    jl bad_input

    cmpb $57, %cl
    jg bad_input

    #convert string to number
    subb $48, %cl

    # Now we have a converted number from string to quadword

    #see if number is even. divb saves the quotient to al, remainder to ah.
    # The remainder, if present, will be returned. If not, al will be returned instead.
    movb %cl, %al
    divb divisor 

    # test uses a bitwise AND to check if a register is zero or not.
    test %ah, %ah
    jnz odd #jump-if-not-zero
    
    movzbl %al, %edi  # move %al value to rdi so can echo it out to error on CLI.
    jmp exit

odd:
    # if odd, send ah to return code (dil)
    movzbl %ah, %edi
    jmp exit

bad_input:
    # movzbl - move zero-extend byte-to-long - fills the extra space in %edi
    # with zeros to prevent junk from messing with our result.
    movzbl %cl, %edi
    jmp exit
    
exit: 
   # Set the exit system call number.
   movq $60, %rax   # move 60 to rax to set up syscall.

   # Perform the system call
    syscall
