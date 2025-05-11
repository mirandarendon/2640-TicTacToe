#Names: Eulalia Pedro Andres, Miranda Rendon, Marlenne Salcido
#2640-12PM

.include "macros.asm"

.data
.space 256 #save space for bitmap colors
	.space 1000 #save space for bitmap
	.eqv BLUE 0x189BCC
	.eqv RED 0xff3769
	.eqv BLACK 0x000000
	.eqv PURPLE 0xf539ff
board: .space 9 
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
	la $s4, board #board address in $s4


#start of gameplay		
aGame:
	ogBoardBitmap
	printString(modePrompt)
	getInt
	move $t0, $v0 #$t0 stores which mode player wants to play

	beq $t0, 1, onePlay
	#beq $t0, 2, twoPlay
	
	#if not valid print prompt and asks again
	printString(reprompt)
	j aGame

#game against computer	
onePlay:
	printString(onePlayerStartPrompt)
	getInt
	move $t3, $v0 # $t3 = current player (1 = user, 2 = CPU)

	# Clear board (optional reset)
	# TODO: implement a clear bitmap if needed

	gameLoop1P:
		beq $t3, 1, userTurn
		beq $t3, 2, cpuTurn
		
	userTurn:
		printString(userTurnPrompt)
	userInput:
		printString(moveChoice)
		getInt
		move $t4, $v0		# $t4 = square to mark
		addi $t5, $t4, -1      # convert to 0-based index
		#sb $t3, 0($s4)         # temporarily use $s4
		add $t6, $s4, $t5
		lb $t7, 0($t6)           # load value from board[square-1]
		bnez $t7, userInput      # if not 0, already taken → ask again
		drawSymbol($t3, $t4)
		sb $t3, 0($t6)           # mark the square
		li $t3, 2                # switch to CPU
		j gameLoop1P

	cpuTurn:
		printString(CPUTurnPrompt)
		# Simple CPU logic: pick square 5 if open, else 1 (for now, hardcoded)
		li $t4, 5
		# TODO: add logic to check if square is taken
		drawSymbol($t3, $t4)
		# TODO: update board array
		# TODO: check win condition
		li $t3, 1  # Switch back to user
		j gameLoop1P
		
		#TODO: jump to replay

#chack if user wants to play again			
replay:		
	printString(anotherRound)
	getInt
	move $t1, $v0 #$t1 stores whether another round will be played
	clearBitmap
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
