# MAKEFILE FOR learning_asm repo
#

# Variables
AS = as
LD = ld

# Pattern rule to build .o file from .asm file
%.o: %.asm
	$(AS) $< -o $@

# Pattern rule to build binary from .o file
%: %.o
	$(LD) $< -o $@

# Clean rule
clean:
	m -f *.o
#	rm -f $(basename $(wildcard *.asm))

