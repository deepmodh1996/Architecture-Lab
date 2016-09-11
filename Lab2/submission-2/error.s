.data
.align 0	######### set to align 2 to remove error
############### error is because alignment is in 2^0 = 1 byte
string1 : .space 23
N : .half 5

.text
main :
la $a0, N
lw $t1, 0($a0)	# trying to load word

li $v0, 10
syscall
