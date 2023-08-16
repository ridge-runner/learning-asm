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
  
