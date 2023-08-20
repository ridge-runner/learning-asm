# ONE SECOND SUM
# A program that increments a number repeatedly for one second.
#

# INPUTS: NONE
#

# PROCESS:
# * Figure out how to call a system timer.
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

.globl _start

.section .data
# none

.section .text

setup:

mainloop:

exit:

movq $60, rax
syscall

