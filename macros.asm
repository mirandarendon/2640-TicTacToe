#Names: Eulalia Pedro Andres, Marlenne Salcido, Miranda Rendon
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
	li $s4, LIBLUE


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
	
	
.end_macro
	
	
	
	
	
	
	
