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
	
	
	
	
	
	
	
