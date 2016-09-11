.text
main:
# Your code starts from the line below
lui $t0, 4096
ori $t0, $t0, 1
lui $t1, 8192
ori $t1, $t1, 2
add $t2, $t0, $t1 #stores sum
li $v0, 10
syscall