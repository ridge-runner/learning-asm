# learning-asm
Learning the basics of assembly. Using x86_64 with the GNU Assembler on Fedora Linux. 

Based on "Learn to Program with Assembly" by Bartlett and "Programming From the 
Ground Up" by Bruno.

## PURPOSE
Understand more about registers, the ALU, memory management, etc., by getting my hands dirty. 

## FILES

NOTE: the results from each program can be seen by using "echo $?" in the CLI.

* myexit.asm - returns an exit code.
  
* arithmetic.asm - shows how basic math is done. Exit code is used to deliver the final result.
  
* maximum.asm - takes an array of longs, finds the largest element, then returns the value via exit code.
  
* arithmatic2.asm - takes a number (string 0-9) from CLI and tests to see if it is even or odd by dividing by 2.
  If odd, the remainder is returned. If even, the quotient is returned. If input is not an ASCII number 0-9,
  the program will return the number of the ASCII symbol. For example, 'A' will return 65.
  
* exponent.s - calculates 2^3 and returns result.

* onesec.s - increments a value for one second, then returns the sum.


### NOTES ON ARITHMETIC 2
This program was based on the example put forth by Bartlett in "Learning to Program with Assembly."  I added the feature where 
a number can be passed to the program via the CLI, then converted from ASCII chars to a number.  I learned a lot about memory pointers, comparing numbers, and how the CPU sees data (all of it is just ... numbers.) Working with the divb instruction was tricky as well since it only
operates on and returns a value to the accumulator (rax). So, I had to add a data reference to make it work.  Furthermore, jmp has to be used a lot, since we don't have {} to define code blocks.  The program will just step into other functions unimpeded.

After wrestling with this (simple) program, I greatly respect the old-time asm programmers who wrote games for third-gen & fourth-gen game consoles and PC games. On one hand, this code is easier to follow, but I can't imagine debugging tens of thousands of lines of x86. 

### LINUX SYSTEM CALLS
While researching onesec.s, I found out how to call system functions using assembly. The Linux System Call Table for 86-64 is helpful for quick reference.
Here is one from Ryan Chapman's blog: https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
To search for the calls in the man pages: man 2 <sys call name>.  The '2' stands for section 2 of the manual.
The call table is great in that it shows which registers handle the parameters for the function. 

*A note about syscalls and their parameter positions:*
* %rax - syscall number
* %rdi - 1st arg
* %rsi - 2nd arg
* %rdx - 3rd arg
* %r10 - 4th arg
* %r8 - 5th arg
* %r9 - 6th arg

The order of registers 10, 8, and 9 is unusual, but that is how they are ordered in Linux systems.

*The default mapping for x86_64 registers and C function parameter positions on Linux:*
* %rdi - 1st arg
* %rsi - 2nd arg
* %rdx - 3rd arg
* %rcx - 4th arg
* %r8 - 5th arg
* %r9 - 6th arg

The register rdi means "destination index" and rsi "source index," followed by rdx "data" and rcx "counter." I've read that their names aren't that important anymore since
they are all general registers. With the exception that rdi and rsi can't access byte-size data types (high byte & low byte.)
