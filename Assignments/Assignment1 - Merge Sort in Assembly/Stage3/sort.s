.global sort
.extern merge
sort: 	stmfd sp!, {r3,r4,r6,r7,r8,r9,r10,r11,lr}
	
	cmp r5,#1
	beq ret				@sorted
	
	cmp r5,#2
	bne general
	mov r9,r8
	add r9,r9,#4
	mov r5,#1
	mov r6,#1	
	bl merge				@takes r5,r6,r8,r9 returns r4(length) and r8(pointer to list) @sorted
	mov r5,r4
	b ret
	
general:
	mov r1,#2
	mov r0,r5
	mov r11,r3
	bl div
	mov r3,r11
	
	sub r6,r5,r0
	mov r5,r0
	
	mov r9,#4
	mul r7,r5,r9
	add r9,r8,r7
	
	bl sort
	
	mov r4,r5
	mov r11,r8
	mov r5,r6
	mov r8,r9
	
	bl sort
	
	mov r6,r5
	
	mov r5,r4
	mov r8,r11
	
	bl merge
	mov r5,r4
	
	b ret				
	
ret:    ldmfd sp!, {r3,r4,r6,r7,r8,r9,r10,r11,pc}
