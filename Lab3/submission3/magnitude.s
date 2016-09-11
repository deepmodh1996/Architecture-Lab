.data
.align 2
A : .space 160
inputLength : .asciiz "Input the length of array A : "
inputElement : .asciiz "Enter the elements of array : "
inputStart : .asciiz "Enter Start : "
inputEnd : .asciiz "Enter End : "
outputMagnitude : .asciiz "Maximum magnitude is : "
outputFrequency : .asciiz " and its frequency is : "

.text
main:

la $a0, inputLength
li $v0, 4
syscall						# print inputLenth

li $v0, 5
syscall
or $t0, $v0, $0				# store lenght in $t0

la $a0, inputElement
li $v0, 4
syscall						# print request for elements of A

la $t1, A 					# $t1 stores address of A
li $t2, 0					# counter for loop

loop : 
	li $v0, 5
	syscall
	sw $v0, 0($t1)					# store in A

	li $v0, 5
	syscall
	sw $v0, 4($t1)					# store in A
	addi $t1, $t1, 8

	addi $t2, $t2, 1			# increment counter
	slt $t3, $t2, $t0 			# $t3 = 1 if counter < length
	bne $t3, $0, loop			# check loop guard

la $a0, inputStart
li $v0, 4
syscall						# print inputStart
li $v0, 5
syscall
or $t5, $v0, $0				# store start index in $t5

la $a0, inputEnd
li $v0, 4
syscall						# print inputEnd
li $v0, 5
syscall
or $t6, $v0, $0				# store end index in $t6


######### call function
# no need to store $t0, $t1, $t2, $t3, $t5, $ra
# list of arguments : $a0 contains pointer to start of array ( A ); $a1 contains start; $a2 contains end
la $a0, A
or $a1, $t5, $0
or $a2, $t6, $0

jal maximumMagnitude


###### return value magnitude in $v0, freq in $v1

or $t0, $v0, $0				# storing magnitude in $t0

la $a0, outputMagnitude
li $v0, 4
syscall
or $a0, $t0, $0
li $v0, 1					# print magnitude
syscall

la $a0, outputFrequency
li $v0, 4
syscall
or $a0, $v1, $0
li $v0, 1
syscall						# print frequency

li $v0, 10
syscall	 					# exit main function





# Pre condition : $a0 contains v.a; $a1 contains v.b
MAGNITUDE :
	# no need to store ra or anything else
	mul $v0, $a0, $a0
	mul $t0, $a1, $a1
	add $v0, $v0, $t0
	jr $ra					# return from function


# list of arguments : $a0 contains pointer to start of array ( A ); $a1 contains start; $a2 contains end
# return value magnitude in $v0, freq in $v1
maximumMagnitude :
	addi $sp, $sp, -16		# creating space to store $ra, $a0, $a1, $a2
	sw $a2, 0($sp)
	sw $a1, 4($sp)
	sw $a0, 8($sp)
	sw $ra, 12($sp)			# end of storing in stack

	addi $t0, $0, -1		# $t0 stores maximum magnitude so for; initialized to -1
	addi $t1, $0, 0			# $t1 stores frequency of maximum magnitude so far; initialized to 0
	

	# linearly checking form index = start to index = end
	or $t2, $a1, $0			# $t2 stores counter for loop
	addi $t3, $a2, 1		# storing end + 1 in $t3

	sll $t5, $a1, 2 
	add $t5, $t5, $a0		# $t5 stores address of A[counter]'s first element ( A[counter].a )
	loopFunction :
		lw $t6, 0($t5)
		or $a0, $t6, $0
		lw $t6, 4($t5)
		or $a1, $t6, $0		# assigning argument to function MAGNITUDE
		addi $t5, $t5, 8	# modifying $t5

		# need to store $t0, $t1, $t2, $t3, $t5 : rest are not required ( already stored in stack )
		addi $sp, $sp, -20
		sw $t5, 0($sp)
		sw $t3, 4($sp)
		sw $t2, 8($sp)
		sw $t1, 12($sp)
		sw $t0, 16($sp)

		jal MAGNITUDE 		# calling function

		lw $t5, 0($sp)
		lw $t3, 4($sp)
		lw $t2, 8($sp)
		lw $t1, 12($sp)
		lw $t0, 16($sp)		# popping back from stack
		addi $sp, $sp, 20	# freeing stack

		or $t6, $v0, $0		# storing magitude of A[counter] in $t6

		addi $t4, $0, 1		# storing 1 in $t4
		slt $t7, $t6, $t0	# $t7 = 1 if magnitude(A[counter]) < max magnitude so far
		beq $t7, $t4, case1
		slt $t7, $t0, $t6	# $t7 = 1 if magnitude(A[counter]) > max magnitude so far
		beq $t7, $t4, case2
		addi $t1, $t1, 1	# max magnitude so far == magnitude(A[counter]); hence incrementing frequency
		j case1
		
		case2 :
			or $t0, $t6, $0	# updating max magnitude so far
			or $t1, $t4, $0 # updating frequency to 1


		case1 : # magnitude(A[counter]) < max magnitude : continue
		addi $t2, $t2, 1	# incrementing counter
		slt $t4, $t2, $t3  	# if counter < (end + 1); $t4 = 1
		bne $t4, $0, loopFunction	# loop guard

	or $v0, $t0, $0
	or $v1, $t1, $0			# setting return value

	lw $ra, 12($sp)			# loading ra
	addi $sp, $sp, 16		# freeing stack

	jr $ra					# returning function