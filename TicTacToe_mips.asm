#Names: Eulalia Pedro Andres, Marlenne Salcido, Miranda Rendon
#2640-12PM

.include "macros.asm"

.data
intro: .asciiz "Welcome to Tic Tac Toe!"
modePrompt: .asciiz "\n\nWould you like to play (1) One Player or (2) Two Player: "
row: .asciiz "----------------------------------------------------------"
anotherRound: .asciiz "\n\nWould you like to play again? (1) Yes or (2) No: "
reprompt: .asciiz "That is not a valid input"
exitMessage: .asciiz "\nThank you for playing!"


.text
main:
	#prints introduction to program string
	printString(intro)


#start of gameplay		
aGame:
	printString(modePrompt)
	getInt
	move $t0, $v0 #$t0 stores which mode player wants to play

	beq $t0, 1, onePlay
	beq $t0, 2, twoPlay
	
	#if neither valid print prompt and asks again
	printString(reprompt)
	j aGame

#game against computer	
onePlay:


#game with two users
twoPlay:
	


#chack if user wants to play again			
replay:		
	printString(anotherRound)
	getInt
	move $t1, $v0 #$t1 stores whether another round will be played
	beq $t1, 1, aGame
	beq $t1, 2, exit
	
	#if neither valid print prompt and asks again
	printString(reprompt)
	j replay
			
							
#exits program
exit:
	printString(exitMessage)
	li $v0, 10
	syscall
