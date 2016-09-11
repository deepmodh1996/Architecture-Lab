.data
newline: .asciiz "\n"
.align 2						# word align
result: .space 4	
	.file	1 "gcd.c"			# name of file from which assembly code is generated
	.text
	.align	2
	.globl	gcd
	.set	nomips16
	.ent	gcd
gcd:	# gcd function call
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4     		# can not understand
	.fmask	0x00000000,0			# can not understand
	.set	noreorder				# can not understand
	.set	reorder					# can not understand
	addiu	$sp,$sp,-8				# createing space in stack
	sw	$fp,4($sp)					# storing $fp in stack
	move	$fp,$sp
	sw	$4,8($fp)					# storing first argument in frame pointer
	sw	$5,12($fp)					# storing $a1 in second argument
$L5:		# for(;;) branch ( start of loop )
	lw	$3,8($fp)					
	lw	$2,12($fp)					# storing values in frame pointer in return registers $v0, $v1
	#nop
	bne	$3,$2,$L2					# if $v0 is not same as $v1, branch to L2
	lw	$2,8($fp)					# $v0 == $v1
	move	$sp,$fp
	lw	$fp,4($sp)					# storing fp
	addiu	$sp,$sp,8				# freeing stack
	j	$31							# return 
$L2:		# a > b
	lw	$3,8($fp)					# loading arguments from frame to $v1, $v0
	lw	$2,12($fp)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L3					# if $2 > $3, branch to L3
	lw	$3,8($fp)					# $a0 > $a1 or $2 < $3 or a > b
	lw	$2,12($fp)				
	#nop
	subu	$2,$3,$2				# modifying values in fp such that $a0 ( 8($fp)) contains $a0-$a1 (second line in gcd function)
	sw	$2,8($fp)					# overwriting $a0 with value $a0 - $a1
	b	$L5						# go to start of infinite for loop
$L3:		# a < b
	lw	$3,12($fp)
	lw	$2,8($fp)					# loading arguments in $2, $3
	#nop
	subu	$2,$3,$2				# modifying values in fp such that $a1( 12($fp)) contains $a1-$a0 (third line in gcd function)
	sw	$2,12($fp)					# overwriting $a0 with value $a1 - $a0
	b	$L5						# go to start of infinite for loop
	.end	gcd
	.align	2
	.globl	main					# can not understand
	.set	nomips16				# can not understand
	.ent	main					# can not understand
main:
	.frame	$fp,48,$31		# vars= 16, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	reorder
	addiu	$sp,$sp,-48				# creating space in stack
	sw	$31,44($sp)				# storing 10, 75 in frame
	sw	$fp,40($sp)
	move	$fp,$sp
	li	$2,10			# 0xa
	sw	$2,32($fp)
	li	$2,75			# 0x4b
	sw	$2,28($fp)
	lw	$4,32($fp)
	lw	$5,28($fp)
	jal	gcd				# calling gcd
	sw	$2,24($fp)					# storing return value of gcd
	lw	$4,24($fp)
	jal	syscall_print_int			# printing
	jal	syscall_print_newline
	move	$sp,$fp
	lw	$31,44($sp)					# popping $ra from stack
	lw	$fp,40($sp)					# popping $fp from stack
	addiu	$sp,$sp,48				# freeing stack
	j	$31							# return back
	.end	main


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

