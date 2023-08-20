# MAKEFILE FOR learning_asm repo
#

# Variables
AS = as -g
LD = ld

# Pattern rule to build .o file from .asm file
%.o: %.s
	$(AS) $< -o $@

# Pattern rule to build binary from .o file
%: %.o
	$(LD) $< -e _start $@

# Clean rule
clean:
	m -f *.o
#	rm -f $(basename $(wildcard *.asm))

