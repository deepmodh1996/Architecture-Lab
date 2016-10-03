.data

		.align		2
N:	.word		5


		.text
		.global	main
main:
		
		add r2,r0,10000
		add r3,r0,10000
		mult r1,r2,r3
		add r1, r2, r0
		sub r3,r1,r0
		trap		0