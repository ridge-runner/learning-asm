# PURPOSE:  A simple program demonstrating simple arithmetic.
# 
#

# INPUT:    none
#
#

# OUTPUT:   Returns status code that is the result of arithmetic operation(s).
#           Result can be seen by calling "echo $?".

.globl _start

.section .data

.section .text

_start:
   # Perform various arithmetic functions
   movq $3, %rdi    # move quadword value 3 into 64b index register
   movq %rdi, %rax  # move index number (3) int accumulator.
   addq %rdi, %rax  # add rdi to rax, rax = 6
   mulq %rdi        # multiply rdi (3) by rax (6), store 18 to rax.
   movq $2, %rdi    # move 2 into rdi
   addq %rdi, %rax  # add rdi(2) to rax(18), store in rax(20)
   addq $4, %rdi    # add 4 to rdi(2), store 6 in rdi
   mulq %rdi        # multiply rdi(6) by rax(20), rax = 120 
   movq %rax, %rdi  # mov rax(120) to rdi. rdi = exit code

   
   # Set the exit system call number.
   movq $60, %rax   # move 60 to rax to set up syscall.

   # Perform the system call
    syscall
