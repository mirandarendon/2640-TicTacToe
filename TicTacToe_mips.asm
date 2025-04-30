#Names: Eulalia Pedro Andres, Marlenne Salcido, Miranda Rendon
#2640-12PM

.include "macros.asm"

.data
	intro: .asciiz "Welcome to Tic Tac Toe!"
	modePrompt: .asciiz "\n\nWould you like to play (1) CPU Mode or (2) Two Player Mode: "
	row: .asciiz "----------------------------------------------------------"
	anotherRound: .asciiz "\n\nWould you like to play again? (1) Yes or (2) No: "
	reprompt: .asciiz "That is not a valid input"
	exitMessage: .asciiz "\nThank you for playing!"

.text
	main:
		#prints introduction to program string
		printString(intro)
		
		#branch in case of repeating gameplay
		aGame:
			printString(modePrompt)
			getInt
			move $t0, $v0 #$t0 stores which mode player wants to play

			
			printString(anotherRound)
			getInt
			move $t1, $v0 #$t1 stores whether another round will be played
			beq $t1, 2, exit
			
			#currently repeats if 2 is not entered. Will create branch to ensure 1 must be entered to continue, otherwise user will be reprompted 
			j aGame
			
			
		
		
		
		#exits program
		exit:
			printString(exitMessage)
			li $v0, 10
			syscall
