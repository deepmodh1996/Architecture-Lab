.data
.align 2
ratio1: .word 0 0 				#default initialisation
ratio2: .word 0 0				#default initialisation
string1 : .asciiz "/"

.text
main :

la $s0, ratio1 				# Address of ratio1 is obtained in $s0 for future use
la $s1, ratio2 				# Address of ratio2 is obtained in $s1 for future use


li $v0, 5
syscall						# cin starts
sw $v0, 0($s0) 
li $v0, 5
syscall
sw $v0, 4($s0)
li $v0, 5
syscall
sw $v0, 0($s1)
li $v0, 5
syscall
sw $v0, 4($s1)				# cin ends

# using $s0, $s1 as argument inplace of $a0, $a1 to avoid copy of register values
jal addFunction

lw $a0, 0($s0)				# cout starts
li $v0, 1
syscall
la $a0, string1
li $v0, 4
syscall
lw $a0, 4($s0)
li $v0, 1
syscall						# cout ends

li $v0, 10
syscall


addFunction :
# loading ratios into registers
lw $t1, 0($s0)
lw $t2, 4($s0)
lw $t3, 0($s1)
lw $t4, 4($s1)

# calculating numerator of result in t1
mul $t1, $t1, $t4
mul $t5, $t3, $t2
add $t1, $t1, $t5

# calculating denomenator of result in t2
mul $t2, $t2, $t4

sw $t1, 0($s0)
sw $t2, 4($s0)

j $31