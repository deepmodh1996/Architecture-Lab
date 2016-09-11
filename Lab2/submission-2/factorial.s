.data
string1 : .asciiz "Give a number : "
string2 : .asciiz "Factorial is : "

.text
main:
la $a0, string1
li $v0, 4					# print string1
syscall

li $v0, 5
syscall						# get integer

or $a1, $0, $v0				# a1 has argument of FACTORIAL
jal FACTORIAL 				# v1 has return value of FACTORIAL

la $a0, string2				# print string2
li $v0, 4
syscall

or $a0, $0, $v1
li $v0, 1					# print factorial
syscall						

li $v0, 10					# exit main
syscall



FACTORIAL :
ori $t1, $0, 1				# counter for loop
ori $t0, $0, 1				# store factorial of number
addi $t3, $a1, 1			# for loop-guard

loop : 	
mul $t0, $t0, $t1			# t4 has last bit of t2 ( counter of loop)

addi $t1, $t1, 1			# increment counter by 1
bne $t1, $t3, loop 			# loop guard

or $v1, $0, $t0				# copy return value in v1
j $31