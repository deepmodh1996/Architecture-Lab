.data
string1 : .asciiz "Give a number : "
string2 : .asciiz " is"
string3 : .asciiz " not"
string4 : .asciiz " even"


.text
main :
la $a0, string1			# print string1
li $v0, 4
syscall
li $v0, 5				# take input
syscall
or $a1, $v0, $0			# argument for function call
jal ISEVEN				# call function

or $a0, $a1, $0
li $v0, 1				# print integer
syscall

la $a0, string2
li $v0, 4				# print "is"
syscall

# check if return value is 1 or 0
bne $v1, $0 , exit
la $a0, string3
syscall
exit : la $a0, string4	# print "even"
syscall

li $v0, 10				# exit from main function
syscall

ISEVEN :
andi $t1, $a1, 1		# t1 has last bit of number
bne $t1, $0, odd		# check if t1 is odd or even
ori $v1, $0, 1	 		# if even
j exit2					# exit if-then-else
odd : or $v1, $0, $0	# if odd

exit2 : j $31			# return 1 or 0 in $v1
