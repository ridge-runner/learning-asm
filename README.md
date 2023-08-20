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
