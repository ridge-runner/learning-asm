#PURPOSE:	This program finds the maximum number of a 
#		    set of data items. This program is x86 (32b).
#

#VARIABLE: The registers have the following uses:
#
#	%edi - Holds the index of the data item being examined.
#   %ebx - Largest data item found.
#	%eax - Current data item.
#

# The following memory locations are used:
#
#   data_items - contains the item data. A 0 is used
#	to terminate the data.
#

.section .data

# .long is the name/addr storing four-word number (0 - 4,000,000,000+)
data_items:         #These are the data items.
.long 3, 67, 34, 222, 45, 75, 54, 34, 44, 33, 22, 11, 66, 0 # total mem = 56B

.section .text

.globl _start
_start:
    movl $0, %edi                   # move long 0 to index reg (reset to 0 index)
    movl data_items(,%edi,4), %eax  # move data_items. start at edi (0), incr 4 words, store to eax.
                                    # Syntax: movl BEGINNINGADDRESS(,%INDEXREGISTER, WORDSIZE)
    movl %eax, %ebx                 # since this is the first item, %eax is biggest.


start_loop:                         # Start loop.
    cmpl $0, %eax                   # check to see if we've hit the end.
    je loop_exit                    # je = jump if equal
    inc1 %edi                       # load next value.
    movl data_items(,%edi, 4), %eax 
    cmpl %ebx, %eax                 # compare values
    jle start_loop                  # jump to loop beginning if less than or equal to first value.

    movl %eax, %ebx                 # move the value as the largest
    jmp start_loop                  # jump to loop beginning

loop_exit:
    # %ebx is the status code for the exit system call
    # and it already has the maximum number
    movl $1, %eax   # 1 is the exit() syscall
    int $0x80       # syscall


