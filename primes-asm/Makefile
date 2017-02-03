all: primes
primes: primes.asm
	nasm -f elf primes.asm
	ld primes.o -o primes
clean:
	rm primes primes.o
