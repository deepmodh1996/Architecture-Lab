.data
var1: .asciiz "Please enter your name : "
var2: .asciiz "Hello "

.text
main:
la $a0, var1 		# load address of var1
li $v0, 4 			# load v0 for print system call
syscall 			# print var1
li $v0, 8 			# load v0 for read string system call
syscall 			# read string
or $t0, $a0, $0 	# store address of input string in t0
la $a0, var2		# load address of var2
li $v0, 4			# load v0 for print system call
syscall				# print var2
or $a0, $t0, $0		# copy t0 (input string address) in a0
syscall				# print input name
li $v0, 10			# load v0 for exit 
syscall				# exit system call