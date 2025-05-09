#Names: Eulalia Pedro Andres, Marlenne Salcido, Miranda Rendon
#2640-12PM

.include "macros.asm"

.data
.space 256 #save space for bitmap colors
	.space 1000 #save space for bitmap
	.eqv BLUE 0x189BCC
	.eqv GREEN 0xbecc41
	.eqv LIBLUE 0x8dd7f8
intro: .asciiz "Welcome to Tic Tac Toe!\n\n"
modePrompt: .asciiz "\n\nWould you like to play (1) One Player or (2) Two Player: "
onePlayerStartPrompt: .asciiz "First move goes to (1) You or (2) CPU: "
twoPlayersStartPrompt: .asciiz "First move goes to (1) Player 1 or (2) Player 2: "
userTurnPrompt: .asciiz "\n---Your Turn---\n"
CPUTurnPrompt: .asciiz "\n---CPU's Turn---\n"
Player1TurnPrompt: .asciiz "\n---Player 1's Turn---\n"
Player2TurnPrompt: .asciiz "\n---Player 2's Turn---\n"
userWins: .asciiz "You win!"
userLoses: .asciiz "You lose!"
player1Wins: "Player 1 wins!"
player2Wins: "Player 2 wins!"
moveChoice: "Which square would you like to mark? Please enter a value from 1-9: "
row: .asciiz "----------------------------------------------------------"
anotherRound: .asciiz "\n\nWould you like to play again? (1) Yes or (2) No: "
reprompt: .asciiz "That is not a valid input"
exitMessage: .asciiz "\nThank you for playing!"


.text
main:
	#prints introduction to program string
	printString(intro)
	ogBoard
	ogBoardBitmap



#start of gameplay		
aGame:
	printString(modePrompt)
	getInt
	move $t0, $v0 #$t0 stores which mode player wants to play

	beq $t0, 1, onePlay
	beq $t0, 2, twoPlay
	
	#if not valid print prompt and asks again
	printString(reprompt)
	j aGame

#game against computer	
onePlay:
	printString(onePlayerStartPrompt)
	getInt
	move $t3, $v0 #$t3 stores who gets the first move
	#logic is currently not accounting for who starts. Might not ask in final product
	printString(userTurnPrompt)
	#if not valid print prompt and asks again
	#printString(reprompt)
	#j onePlay
	
	printString(moveChoice)
	getInt
	move $t4, $v0 #$t4 store where user wants to mark
	j replay
	#game with two users
	twoPlay:
	printString(twoPlayersStartPrompt)
	getInt
	move $t3, $v0 #$t3 stores who gets the first move
	#logic is currently not accounting for who starts. Might not ask in final product

	#Player 1 Turn
	printString(Player1TurnPrompt)
	printString(moveChoice)
	getInt
	move $t4, $v0 #$t4 store where Player 1 wants to mark
	#Player 2 Turn
	printString(Player2TurnPrompt)
	printString(moveChoice)
	getInt
	move $t5, $v0 #$t5 store where Player 2 wants to mark

	j replay

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

#trap to catch improper data types
.kdata
	invalid: .asciiz"\nImproper input. Value is not an integer\n"
.ktext 0x80000180
	li $v0, 4
	la $a0, invalid
	syscall
	move $v0,$k0   # Restore $v0
   	move $a0,$k1   # Restore $a0
   	mfc0 $k0,$14   # Coprocessor 0 register $14 has address of trapping instruction
   	addi $k0,$k0,4 # Add 4 to point to next instruction
   	mtc0 $k0,$14   # Store new address back into $14
   	eret           # Error return; set PC to value in $14
	#la $k0, aGame #load address of main in .text
	#mtc0 $k0, $14 #move main address to coprocessor return address register
	#eret #return back to program as specified (Basically jummps to value in register $14)
