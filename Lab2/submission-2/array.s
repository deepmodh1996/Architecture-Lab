.data
.align 2
A : .space 32
string1 : .asciiz "Sum of values at "
evenString : .asciiz "even"
oddString : .asciiz "odd"
string2 : .asciiz " locations is larger\n"

.text
main :

li $t8, 0				# sum of values at odd locations
li $t9, 0				# sum of values at even locations

la $t0, A 				# store address of word to store ( initialized to A's address )
li $t2, 0				# counter for loop
li $t3, 8				# number of iteration in loop

loop : 	li $v0, 5		# do-while loop, set v0 to read string
syscall
sw $v0, 0($t0)			# store word in memory using proper off-set
andi $t4, $t2, 1		# t4 has last bit of t2 ( counter of loop)
bne $t4, $0, odd		# check if t4 is odd or even
add $t8, $t8, $v0 		# modify sum of even locations
j exit					# exit if-then-else
odd : add $t9, $t9, $v0 # modify sum of odd locations

exit : addi $t0, $t0, 4	# increment address to store by 4
addi $t2, $t2, 1		# increment counter by 1
bne $t2, $t3, loop 		# loop guard


la $a0, string1
li $v0, 4
syscall

slt $t5, $t8, $t9		# t5 = 1 if sum of odd locations < sum of even locations; 0 otherwise
beq $t5, $0, print2		# if-then-else
or $t6, $0, $t9			# t6 stores largest of sum
la $a0, evenString
j exit2
print2 : or $t6, $0, $t8
la $a0, oddString

exit2 : li $v0, 4		# print "odd" or "even"
syscall

la $a0, string2
syscall
or $a0, $0, $t6			# print string2
li $v0, 1
syscall

li $v0, 10				# exit
syscall