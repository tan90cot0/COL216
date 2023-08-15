.global merge
.text

merge:	stmfd sp!, {r3,r5,r6,r7,r8,r9,r10,r11,lr}
	mov r12, r8
	ldr r7,=temp				@r7 contains the pointer to the temporary merged list
	mov r4,#0				@r4 contains the size of the merged list

here:	bl comp				@(r8,r9 start of list pointers, r10 capital, r11 result)
	
	cmp r11,#-1
	beq first
	cmp r11,#1
	beq second
	
	cmp r3,#0
	beq first
				
	add r8,r8,#4				@remove duplicates, if no remove duplicates, call first
	sub r5,r5,#1
	
	cmp r5,#0
	beq decide
	
	b here
	

first:
	ldr r0,[r8]
	str r0,[r7]
	add r8,r8,#4
	add r7,r7,#4
	
	sub r5,r5,#1
	add r4,r4,#1
	cmp r5,#0
	beq decide
	b here	
	
second: ldr r0,[r9]
	str r0,[r7]
	add r9,r9,#4
	add r7,r7,#4
	sub r6,r6,#1
	add r4,r4,#1
	cmp r6,#0
	beq decide
	b here
	
decide: 
	cmp r5,#0
	bne rm1
	cmp r6,#0
	bne rm2
	b exit
	
rm1:  	ldr r0,[r8]
	str r0,[r7]
	add r7,r7,#4
	
	add r8,r8,#4
	sub r5,r5,#1
	add r4,r4,#1
	b decide
	
rm2: 	ldr r0,[r9]
	str r0,[r7]
	add r7,r7,#4
	
	add r9,r9,#4
	sub r6,r6,#1
	add r4,r4,#1
	
	b decide

exit:	mov r5,#0					@loop variable
	ldr r7,=temp
	mov r8,r12

loop:   cmp r5,r4
	beq out
		
	ldr r0,[r7]
	str r0,[r8]
	add r8,r8,#4
	add r7,r7,#4
	add r5,r5,#1
	b loop
	
out:	
	ldmfd sp!, {r3,r5,r6,r7,r8,r9,r10,r11,pc}	
	
	
.data
temp: .space 20000
