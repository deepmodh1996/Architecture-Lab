		.data


A: .word 1, 2, 3, 4, 5, 6
B: .word 2, 3, 4, 5, 6, 7
C: .word 0, 0, 0, 0, 0, 0
D: .word 0, 0, 0, 0, 0, 0
N: .word 6
alpha: .word 10

		.text
		.global	main
main:
		lw r2, N 		; value of N in r2 ; N-- as counter
		addi r3, r0, 0	; 4*counter

Loop:		
		addi r4, r3, A
		lw r4, 0(r4)
		addi r5, r3, B
		lw r5, 0(r5)
		
		mult r6, r4, r5
		addi r8, r3, C
		sw 0(r8), r6

		addi r4, r3, D
		lw r4, 0(r4)
		
		lw r7, alpha
		mult r7, r7, r6
		
		add r4, r4, r7
		addi r8, r3, D
		sw 0(r8), r4

		addi r3, r3, 4
		addi r2, r2, -1	;for N only even comment these and decrement r2 by 2 just before bnez at end of loop
		beqz r2, Exit	; comment this		


;;; following code has to be repeated to support unrolling. ( trade off : code size vs unrolling )

		addi r4, r3, A
		lw r4, 0(r4)
		addi r5, r3, B
		lw r5, 0(r5)
		
		mult r6, r4, r5
		addi r8, r3, C
		sw 0(r8), r6

		addi r4, r3, D
		lw r4, 0(r4)
		
		lw r7, alpha
		mult r7, r7, r6
		
		add r4, r4, r7
		addi r8, r3, D
		sw 0(r8), r4

		addi r3, r3, 4
		addi r2, r2, -1
		bnez r2, Loop

Exit:
		; un comment following to check in registers
		;lw r10, D+0
		;lw r11, D+4
		;lw r12, D+8
		;lw r13, D+12
		;lw r14, D+16
		;lw r15, D+20
		trap 		0