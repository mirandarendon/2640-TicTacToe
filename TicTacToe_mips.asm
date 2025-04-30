#Names: Eulalia Pedro Andres, Marlenne Salcido, Miranda Rendon
#2640-12PM

.include "macros.asm"

.data
	row: .asciiz "----------------------------------------------------------"

.text
	main:
		printString(row)
		
		li $v0, 10
		syscall
