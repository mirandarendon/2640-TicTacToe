#Names: Eulalia Pedro Andres, Miranda Rendon, Marlenne Salcido
#macros

.macro printString(%string)
	li $v0, 4
	la $a0, %string
	syscall
.end_macro

.macro printInt(%int)
	li $v0, 1
	move $a0, %int
	syscall
.end_macro

.macro getInt
	li $v0, 5
	syscall
.end_macro

.macro ogBoard
	.data
	line: .asciiz "\n-------------------------------------------------\n"
	row1: .asciiz "\t1\t|\t2\t|\t3\t"
	row2: .asciiz "\t4\t|\t5\t|\t6\t"
	row3: .asciiz "\t7\t|\t8\t|\t9\t"
	
	.text
	printString(row1)
	printString(line)
	printString(row2)
	printString(line)
	printString(row3)
.end_macro 
	
.macro ogBoardBitmap

	add $s2, $zero, 1
	la $s0, 0x10010000
	li $s1, BLUE
	


	rows:
	sw $s1, 16($s0)
	addi $s0, $s0, 4
	sw $s1, 16($s0)
	addi $s0, $s0, 20
	sw $s1, 16($s0)
	addi $s0, $s0, 4
	sw $s1, 16($s0)
	add $s2, $s2, 1
	beq $s2, 17, readjust
	addi $s0, $s0, 36
	j rows
	readjust:
	subi $s0, $s0, 988
	add $s2, $zero, 1
	cols:
	sw $s1, 256($s0)
	addi $s0, $s0, 64
	sw $s1, 256($s0)
	addi $s0, $s0, 320
	sw $s1, 256($s0)
	addi $s0, $s0, 64
	sw $s1, 256($s0)
	add $s2, $s2, 1
	beq $s2, 17, done
	subi $s0, $s0, 444
	j cols
	done:
	#resets base address to first block
	subi $s0, $s0, 508
.end_macro

#draws symbol of player (should only run after input is validated)
.macro drawSymbol(%player, %square)
	#branches for each of the 9 squares
	beq %square, 1, pixel_0
	beq %square, 2, pixel_24
	beq %square, 3, pixel_48
	beq %square, 4, pixel_384
	beq %square, 5, pixel_408
	beq %square, 6, pixel_432
	beq %square, 7, pixel_768
	beq %square, 8, pixel_792
	beq %square, 9, pixel_816
	
	#sets starting base adress to corresponding pixel (top left corner of square) for each square 
	pixel_0:
	addi $s0, $s0, 0
	#jumps and links to label that draws symbol
	jal symbol
	#resets base address to first pixel
	subi $s0, $s0, 204
	j endDrawing
	
	pixel_24:
	addi $s0, $s0, 24
	#jumps and links to label that draws symbol
	jal symbol
	#resets base address to first pixel
	subi $s0, $s0, 228
	j endDrawing
	
	pixel_48:
	addi $s0, $s0, 48
	#jumps and links to label that draws symbol
	jal symbol
	#resets base address to first pixel
	subi $s0, $s0, 252
	j endDrawing
	
	pixel_384:
	addi $s0, $s0, 384
	#jumps and links to label that draws symbol
	jal symbol
	#resets base address to first pixel
	subi $s0, $s0, 588
	j endDrawing
	
	pixel_408:
	addi $s0, $s0, 408
	#jumps and links to label that draws symbol
	jal symbol
	#resets base address to first pixel
	subi $s0, $s0, 612
	j endDrawing
	
	pixel_432:
	addi $s0, $s0, 432
	#jumps and links to label that draws symbol
	jal symbol
	#resets base address to first pixel
	subi $s0, $s0, 636
	j endDrawing
	
	pixel_768:
	addi $s0, $s0, 768
	#jumps and links to label that draws symbol
	jal symbol
	#resets base address to first pixel
	subi $s0, $s0, 972
	j endDrawing
	
	pixel_792:
	addi $s0, $s0, 792
	#jumps and links to label that draws symbol
	jal symbol
	#resets base address to first pixel
	subi $s0, $s0, 996
	j endDrawing
	
	pixel_816:
	addi $s0, $s0, 816
	#jumps and links to label that draws symbol
	jal symbol
	#resets base address to first pixel
	subi $s0, $s0, 1020
	j endDrawing
	
	#label to draw actual symbol
	symbol:
	#branches based on which player's turn it is
	beq %player, 1, symX
	beq %player, 2, symO
		#draws X in square if Player 1
		symX:
			li $s1, RED
			sw $s1, 0($s0)
			addi $s0, $s0, 12
			sw $s1, 0($s0)
			addi $s0, $s0, 56
			sw $s1, 0($s0)
			addi $s0, $s0, 4
			sw $s1, 0($s0)
			addi $s0, $s0, 60
			sw $s1, 0($s0)
			addi $s0, $s0, 4
			sw $s1, 0($s0)
			addi $s0, $s0, 56
			sw $s1, 0($s0)
			addi $s0, $s0, 12
			sw $s1, 0($s0)
			jr $ra
		
		#draws O in square if Player 2
		symO:
			li $s1, PURPLE
			addi $s0, $s0, 4
			sw $s1, 0($s0)
			addi $s0, $s0, 4
			sw $s1, 0($s0)
			addi $s0, $s0, 56
			sw $s1, 0($s0)
			addi $s0, $s0, 12
			sw $s1, 0($s0)
			addi $s0, $s0, 52
			sw $s1, 0($s0)
			addi $s0, $s0, 12
			sw $s1, 0($s0)
			addi $s0, $s0, 56
			sw $s1, 0($s0)
			addi $s0, $s0, 4
			sw $s1, 0($s0)
			addi $s0, $s0, 4
			jr $ra
	
	endDrawing:
.end_macro

.macro clearBitmap
	add $s2, $zero, 1
	clearLoop:
	li $s1, BLACK
	sw $s1, 0($s0)
	addi $s0, $s0, 4
	addi $s2, $s2, 1
	beq $s2, 257, cleared
	j clearLoop
	cleared:
		subi $s0, $s0, 1020
.end_macro
	
	
	
	
