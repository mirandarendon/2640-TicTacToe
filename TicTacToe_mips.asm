#Names: Eulalia Pedro Andres, Marlenne Salcido, Miranda Rendon
#2640-12PM

.include "macros.asm"

.data
	modePrompt: .asciiz "Welcome to Tic Tac Toe!\n\nWould you like to play (1) CPU Mode or (2) Two Player Mode: "
	row: .asciiz "----------------------------------------------------------"

.text
	main:
		printString(modePrompt)
		
		li $v0, 10
		syscall
