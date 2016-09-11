.data
inputString : .asciiz "Enter n: "
outputString : .asciiz "The value of F(n) is: "

.text
main:
la $a0, inputString
li $v0, 4					# print input string
syscall

li $v0, 5					# read n
syscall

addi $sp, $sp, -4
sw $v0, 0($sp)				# store n in stack before function call

# no need to store $ra
or $a0, $v0, $0				# passing n as argument ( already stored in stack )
jal FUNCTION

or $t0, $v0, $0				# storing return value in $t0
addi $sp, $sp, 4			# freeing stack

la $a0, outputString
li $v0, 4					# print output string
syscall

or $a0, $t0, $0
li $v0, 1
syscall						# print answer

li $v0, 10
syscall						# exit main function

FUNCTION :


slti $t0, $a0, 101			# if n < 100; t0 is 1
ori $t1, $0, 1				# storing 1 in $t1
beq $t0, $t1, lessThan
# no need to store $a0 or $ra
addi $v0, $a0, -10			# return value
jr $ra

lessThan :
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)				# storing ra in stack; no need to store argument

	addi $a0, $a0, 11			# passing argument
	jal FUNCTION 				# calling function

	addi $a0, $v0, 0			
	jal FUNCTION 				# calling function again

	lw $ra, 0($sp)				# storing back ra
	addi $sp, $sp, 4			# free stack

	jr $ra 						# return