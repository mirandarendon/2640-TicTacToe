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
	.data
		.eqv BLACK 0x000000
	.text
	add $s2, $zero, 1
	clearLoop:
	li $s1, BLACK
	sw $s1, 0($s0)
	addi $s0, $s0, 4
	addi $s2, $s2, 1
	beq $s2, 257, cleared
	j clearLoop
	cleared:
		subi $s0, $s0, 1024
.end_macro
	

.macro checkWinner(%boardPtr, %resultReg)
	move $t2, %boardPtr  # base pointer to board
	li $t9, 0            # default = no winner

	# --- Check each win combination ---
	# Format: if posA == posB == posC and not 0 → win

	# Row 1: 0 1 2
	lb $s1, 0($t2)
	lb $s2, 1($t2)
	lb $s3, 2($t2)
	beqz $s1, skip1
	beq $s1, $s2, r1check
	j skip1
r1check: beq $s2, $s3, winFound
skip1:
	# Row 2: 3 4 5
	lb $s1, 3($t2)
	lb $s2, 4($t2)
	lb $s3, 5($t2)
	beqz $s1, skip2
	beq $s1, $s2, r2check
	j skip2
r2check: beq $s2, $s3, winFound
skip2:
	# Row 3: 6 7 8
	lb $s1, 6($t2)
	lb $s2, 7($t2)
	lb $s3, 8($t2)
	beqz $s1, skip3
	beq $s1, $s2, r3check
	j skip3
r3check: beq $s2, $s3, winFound
skip3:
	# Col 1: 0 3 6
	lb $s1, 0($t2)
	lb $s2, 3($t2)
	lb $s3, 6($t2)
	beqz $s1, skip4
	beq $s1, $s2, c1check
	j skip4
c1check: beq $s2, $s3, winFound
skip4:
	# Col 2: 1 4 7
	lb $s1, 1($t2)
	lb $s2, 4($t2)
	lb $s3, 7($t2)
	beqz $s1, skip5
	beq $s1, $s2, c2check
	j skip5
c2check: beq $s2, $s3, winFound
skip5:
	# Col 3: 2 5 8
	lb $s1, 2($t2)
	lb $s2, 5($t2)
	lb $s3, 8($t2)
	beqz $s1, skip6
	beq $s1, $s2, c3check
	j skip6
c3check: beq $s2, $s3, winFound
skip6:
	# Diagonal 1: 0 4 8
	lb $s1, 0($t2)
	lb $s2, 4($t2)
	lb $s3, 8($t2)
	beqz $s1, skip7
	beq $s1, $s2, d1check
	j skip7
d1check: beq $s2, $s3, winFound
skip7:
	# Diagonal 2: 2 4 6
	lb $s1, 2($t2)
	lb $s2, 4($t2)
	lb $s3, 6($t2)
	beqz $s1, noWinYet
	beq $s1, $s2, d2check
	j noWinYet
d2check: beq $s2, $s3, winFound
# No win yet — check for tie
noWinYet:
	li $t8, 0      # index = 0
	li $t9, 3      # default to tie
	move $t5, $t2
tieScan:
	lb $t7, 0($t2)
	beqz $t7, stillPlaying  # if any cell is empty → still playing
	addi $t8, $t8, 1
	addi $t2, $t2, 1
	li $t6, 9
	blt $t8, $t6, tieScan
	j endCheck
stillPlaying:
	li $t9, 0      # not tie, not win → game still going
endCheck:
	move $t2, $t5
	move %resultReg, $t9
	j finishCheck
winFound:
	move %resultReg, $s1

finishCheck:
.end_macro

.macro resetBoard(%boardPtr)
    li $t0, 0 # index
    move $t2, %boardPtr

resetLoop:
    sb $zero, 0($t2)
    addi $t2, $t2, 1
    addi $t0, $t0, 1
    blt $t0, 9, resetLoop
.end_macro

