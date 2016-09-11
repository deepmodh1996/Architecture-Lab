.data
inputString1 : .asciiz "Enter the pair x,y: "
inputString2 : .asciiz "Enter the coefficients a,b,c :"
outputString : .asciiz "The value of polynomial at given point is: "

.text
main:

la $a0, inputString1
li $v0, 4					# print input string 1
syscall

li $v0, 5					# read p1.x
syscall

addi $sp, $sp, -20			# giving space for 5 int to be stored in stack
or $t0, $sp, $0 			# store stack pointer in t0
sw $v0, 0($sp)				# store p1.x

li $v0, 5					# read p1.x
syscall
sw $v0, 4($sp)				# store p1.y

la $a0, inputString2
li $v0, 4
syscall

li $v0, 5
syscall
sw $v0, 8($sp)				# store c1.a


li $v0, 5
syscall
sw $v0, 12($sp)				# store c1.b

li $v0, 5
syscall
sw $v0, 16($sp)				# store c1.c

# no need to store $t0 before function call
or $a0, $t0, $0				# passing argument as stack pointer in a0

jal EVALUATE				# call function

or $t0, $v0, $0				# storing return of function in $t0
addi $sp, $sp, 20			# free stack

la $a0, outputString
li $v0, 4					# print output string
syscall

or $a0, $t0, $0
li $v0, 1
syscall						# print answer

li $v0, 10
syscall						# exit main function




EVALUATE :

# no need to push ra or fp or s0

lw $t0, 0($a0)				# loading p1.x in $t0
lw $t1, 4($a0)				# loading p1.y in $t1
lw $t2, 8($a0)				# loading c1.a in $t2
lw $t3, 12($a0)				# loading c1.b in $t3
lw $t4, 16($a0)				# loading c1.c in $t4

mul $t5, $t0, $t0			# $t5 contains temporary multiplication
mul $t5, $t5, $t2
addi $v0, $t5, 0

mul $t5, $t0, $t1			# second term in return
mul $t5, $t5, $t3
add $v0, $v0, $t5

mul $t5, $t1, $t1			# third term in return
mul $t5, $t5, $t4
add $v0, $v0, $t5

jr $ra