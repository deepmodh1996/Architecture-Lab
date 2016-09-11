.data
newLine : .asciiz "\n"

.text
main:

li $a0, 10					# passing arguments
li $a1, 75

addi $sp, $sp, -8
sw $a0, 4($sp)				# storing arguments in stack
sw $a1, 0($sp)

jal GCD

or $t0, $v0, $0				# $t0 stores value of gcd

addi $sp, $sp, 8			# freeing stack

or $a0, $v0, $0				# printing c
li $v0, 1
syscall
la $a0, newLine
li $v0, 4					# printing newline
syscall

li $v0, 10
syscall

GCD :
	# keeping x, y in $a0, $a1
	beq $a0, $a1, RET

	bgt $a0, $a1, xgty
	sub $a1, $a1, $a0				# $a0 < $a1
	b GCD
	xgty : sub $a0, $a0, $a1
		b GCD

	RET :
		or $v0, $a0, $0
		jr $ra 						# return