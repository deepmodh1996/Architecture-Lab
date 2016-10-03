.data

		.align		2
N:	.word		5


		.text
		.global	main
main:
		
		
		addi r1,r0,1
		seq r2,r1,r0
		bnez r2,Result
		addi r2,r1,4
		trap		0

Result:
		trap		0