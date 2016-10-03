.data

		.align		2
N:	.word		5


		.text
		.global	main
main:
		
		lw r1, N
		bnez r1,Result 
		trap		0

Result:
		trap		0