# My first x86_64 asm program.
# A simple entry and exit.

.globl _start  # .directive that makes the data persist after assembly.

.section .text # Creates a section called text were the code is written.

_start: # label that defines the value of the _start symbol.
    movq $60, %rax  #Move quadword value $60 to RAX register (x64). $ means value, not address. 60=exit syscall.
    movq $100, %rdi #Move value $100 to RDI register. rdi holds exit status of program.
    syscall #Call kernel/OS to execute instructions stored in rax & rdi.

#End of File
