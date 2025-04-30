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