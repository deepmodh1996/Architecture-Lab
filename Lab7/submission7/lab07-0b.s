.data

		.align		2
N:	.word		5


		.text
		.global	main
main:
		
		
		lw r1, N
		bnez r1,Result		; branch for control stall
		addi r3,r0,4
		addi r4,r0,5
		trap		0

Result:
		addi r5, r0, 10
		trap 		0