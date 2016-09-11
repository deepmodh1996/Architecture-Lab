.data
newLine : .asciiz "\n"

.text
main:

li $a0, 1
li $a1, 2
li $a2, 10						# passing arguments
								
jal FIBONACCI					#no need to store anything

or $t1, $v0, $0					# storing fibonacci(1,2,10) in $t1

or $a0, $v0, $0
li $v0, 1						# printing a
syscall

la $a0, newLine
li $v0, 4						# print new line
syscall

li $v0, 10
syscall							# exit main function

FIBONACCI:
	addi $sp, $sp, -16
	sw $ra, 12($sp)				# storing arguments
	sw $a0, 8($sp)
	sw $a1, 4($sp)
	sw $a2, 0($sp)

	ori $t0, $0, 1				# storing 1 in $t0, no need to save $t0 in stack
	
	blt $a2, $t0, ltone			# checking conditions
	beq $a2, $t0, eqone
	add $t0, $t0, $t0
	beq $a2, $t0, eqtwo

	addi $a2, $a2, -1
	jal FIBONACCI 				# calling fibonacci(first,second,n­-1)

	addi $sp, $sp, -4			# storing fibonacci(first,second,n­-1) 
	sw $v0, 0($sp)

	lw $a2, 4($sp)				# loading $a2
	addi $a2, $a2, -2
	jal FIBONACCI 				# calling fibonacci(first,second,n­-2) 
	
	lw $t2, 0($sp)
	addi $sp, $sp, 4			# freeing stack
	add $v0, $v0, $t2			# returning answer
	b RET

	ltone : 					# n less than 1
		li $v0, -1
		b RET

	eqone : 
		or $v0, $a0, $0
		b RET

	eqtwo :
		or $v0, $a1, $0
		b RET

	RET : 						# return
		lw $ra, 12($sp)			# storing back $ra
		addi $sp, $sp, 16		# freeing stack
		jr $ra
