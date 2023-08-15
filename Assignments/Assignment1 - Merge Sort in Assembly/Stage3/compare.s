.global comp

comp:	stmfd sp!, {r3,r4,r5,r6,r7,r8,r9,r10,lr}
	mov r4,#0
	mov r7,#0
	
	
init1:	ldr r5,[r8]
	ldr r6,[r9]
	mov r0,r5
	bl strlen
	sub r0,r0,#1
	cmp r0,r4
	addeq r7,r7,#1
	
second: mov r0,r6
	bl strlen
	sub r0,r0,#1
	cmp r0,r4
	addeq r7,r7,#2
	
	cmp r7,#3
	beq eq

 	cmp r7,#2
	beq great
	
 	cmp r7,#1
	beq less
		
check:
	ldr r5,[r8]
	ldr r6,[r9]
	add r5,r5,r4
	add r6,r6,r4
	
	ldrb r5,[r5]
	ldrb r6,[r6]
	
	cmp r10,#0
	beq case5
	
compare:
	cmp r5,r6
	bne not
	add r4,r4,#1
	b init1

case5: cmp r5,#65
	bge capital5
	
case6:	cmp r6,#65
	bge capital6
	
capital5: cmp r5,#90
	  bgt l1
	  add r5,r5,#32
l1:	  b case6
	 
capital6: cmp r6,#90
	  bgt l2
	  add r6,r6,#32
l2:	  b compare
		
not:	cmp r5,r6	
	blt less
	b great
	
less: 	mov r11,#-1
	ldmfd sp!, {r3,r4,r5,r6,r7,r8,r9,r10,pc}
	
great:  mov r11,#1
	ldmfd sp!, {r3,r4,r5,r6,r7,r8,r9,r10,pc}

eq:	 	
	mov r11,#0
	ldmfd sp!, {r3,r4,r5,r6,r7,r8,r9,r10,pc}
	
