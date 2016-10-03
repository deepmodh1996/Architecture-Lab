.data

		.align		2
N:	.word		5


		.text
		.global	main
main:
		
		
		lw r1, N
		addi r4,r0,4
		addi r2,r1,4
		trap		0