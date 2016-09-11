.data
N: .word 5
X: .word 2 4 6 8 10
SUM: .word 0
.text
main:
#code starts here
lw $s0, N # counter for loop
la $t0, X
li $t9, 0 # tempsum
loop : lw $t1, 0($t0)
add $t9, $t9, $t1
addi $t0, $t0, 4
addi $s0, $s0, -1
bne $s0, $0, loop
sw $t9, SUM # store the final tota
li $v0, 10
syscall