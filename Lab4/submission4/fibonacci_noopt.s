
.data
newline: .asciiz	"\n"
.align 2
result: .space 4
	.file	1 "fibonacci.c"
	.text
	.align	2
	.globl	fibonacci
	.set	nomips16
	.ent	fibonacci
fibonacci:	# call of main function
	.frame	$fp,40,$31		# vars= 0, regs= 3/0, args= 16, gp= 8
	.mask	0xc0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	reorder
	addiu	$sp,$sp,-40					# creating space in stack
	sw	$31,36($sp)						# storing $ra,$fp,$s0 in stack
	sw	$fp,32($sp)
	sw	$16,28($sp)
	move	$fp,$sp
	sw	$4,40($fp)						# storing $a0,$a1,$a2 in frame
	sw	$5,44($fp)
	sw	$6,48($fp)
	lw	$2,48($fp)						# loading value of n in $2 
	#nop
	bgtz	$2,$L2					# if n > 0 go to L2
	li	$2,-1			# 0xffffffffffffffff	set return value $v0, to -1
	b	$L3							# branch to return Label
$L2:	# n > 0
	lw	$3,48($fp)
	li	$2,1			# 0x1
	bne	$3,$2,$L4		# if n != 1; go to L4
	lw	$2,40($fp)		# set return value $v0, to first ( $a0 stored in 40($fp))
	b	$L3
$L4:	# n > 1; that is n>0 and n != 1
	lw	$3,48($fp)
	li	$2,2			# 0x2
	bne	$3,$2,$L5		# if n != 2; go to L5
	lw	$2,44($fp)		# set return value $v0, to second ( $a1 stored in 44($fp))
	b	$L3
$L5:	# n > 2
	lw	$2,48($fp)
	#nop
	addiu	$2,$2,-1		# store (n-1) in $2
	lw	$4,40($fp)
	lw	$5,44($fp)			# pop appropriate arguments from frame and $2 to $a0, $a1, $a2
	move	$6,$2
	jal	fibonacci			# call fibonacci(first, second, n-1)
	move	$16,$2			# storing return value of function in $s0
	lw	$2,48($fp)
	#nop
	addiu	$2,$2,-2		# store (n-2) in $2
	lw	$4,40($fp)
	lw	$5,44($fp)			# pop appropriate arguments from frame and $2 to $a0, $a1, $a2
	move	$6,$2
	jal	fibonacci			# call fibonacci(first, second, n-2)
	addu	$2,$16,$2		# set return value $v0, to sum of return value of two function calls
$L3:	# return label
	move	$sp,$fp
	lw	$31,36($sp)						# popping $ra from stak
	lw	$fp,32($sp)						# popping back values form stack 
	lw	$16,28($sp)
	addiu	$sp,$sp,40					# freeing stack
	j	$31							# return
	.end	fibonacci
	.align	2
	.globl	main
	.set	nomips16
	.ent	main
main:
	.frame	$fp,40,$31		# vars= 8, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	reorder
	addiu	$sp,$sp,-40				# allocating space in stack by decrementing stack pointer
	sw	$31,36($sp)					# storing $ra, $fp in stack
	sw	$fp,32($sp)
	move	$fp,$sp
	li	$4,1			# 0x1
	li	$5,2			# 0x2			setting appropriate arguments in $a0, $a1, $a2
	li	$6,10			# 0xa
	jal	fibonacci					# calling fibonacci function
	sw	$2,24($fp)					# storing return value of fibonacci function
	lw	$4,24($fp)
	jal	syscall_print_int			# printing
	jal	syscall_print_newline
	move	$sp,$fp
	lw	$31,36($sp)					# popping $ra from stack
	lw	$fp,32($sp)					# popping $fp from stack
	addiu	$sp,$sp,40
	j	$31							# return back
	.end	main



.text


syscall_print_int:
	addi $sp, $sp, -4
	sw $ra, 0($sp)					# storing return address
	li	$v0, 1
	# Using $a0 as argument
	syscall
	lw $ra, 0($sp)					# printing integer stored in $a0
	addi $sp, $sp, 4				# freeing stack
	jr	$ra
	nop

syscall_print_newline:
	addi $sp, $sp, -4
	sw $ra, 0($sp)					# storing return address
	li	$v0, 4
	la	$a0, newline 				# printing new line
	syscall
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra							# return back
	nop



