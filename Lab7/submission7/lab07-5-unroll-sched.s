
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
		; code has been rearranged many times thus showing which line is shifted where is complicated
		lw r4, A(r3)		
		lw r5, B(r3)
		addi r13, r3, 4	
		mult r6, r4, r5
		addi r3, r3, 8
		addi r2, r2, -2			
		lw r17, alpha		
		lw r4, D(r3)		
		mult r7, r17, r6		
		lw r14, A(r13)		
		lw r15, B(r13)		
		sw C(r3), r6
		add r4, r4, r7		
		mult r16, r14, r15		
		sw D(r3), r4		
		lw r14, D(r13)		
		mult r17, r17, r16		
		sw C(r13), r16				
		add r14, r14, r17		
		sw D(r13), r14		
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