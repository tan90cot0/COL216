.text
	ldr r8,=par
	mov r4,#1
	str r4,[r8]
	mov r4,#0
	mov r7,#0
	
	ldr r0,=s1
	bl input_string
	ldr r5,=s1
	ldr r0,=s1
	bl strlen
	mov r10,r0
	sub r10,r10,#1
	
	ldr r0,=s2
	bl input_string
	ldr r6,=s2
	ldr r0,=s2
	bl strlen
	mov r9,r0
	sub r9,r9,#1
	
	bl input_number
	mov r11, r0
	
init:	
	cmp r10,r4
	beq cond1
	
second: 
	cmp r9,r4
	beq cond2
	b end
	
cond1:  b eq
	add r7,r7,#1
	b second

cond2:	add r7,r7,#2
	b end

end:	cmp r7,#3
	bne b1
	b eq

b1: 	cmp r7,#2
	bne b2
	b great
	
b2: 	cmp r7,#1
	bne check
	b less
		
check:
	ldr r5,=s1
	add r5,r5,r4
	ldrb r5,[r5]
	ldr r6,=s2
	add r6,r6,r4
	ldrb r6,[r6]
	cmp r11,#0
	beq case5
	
compare:cmp r5,r6
	bne not
	add r4,r4,#1
	b init

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
	
print:  str r4,[r8,#4]
	bl strlen
	str r0,[r8,#8]
	mov r1,r8
	mov r0,#5
	swi 0x123456
	mov r0,#0x18
	swi 0x123456
	
less: 	ldr r4,=lesser
	ldr r0,=lesser
	b print

great:  ldr r4,=greater
	ldr r0,=greater
	b print

eq:  	ldr r4,=equal
	ldr r0,=equal
	b print
	
strlen:
	stmfd	sp!, {r1-r3,lr}
	mov	r1, #0
	mov	r3, r0
1:	ldrb	r2, [r3], #1
	cmp	r2, #0
	bne	1b
	sub	r0, r3, r0
	ldmfd	sp!, {r1-r3,pc}
	
.data
par: .word 0,0,0
operands: .word 0, 0, 0
s1: .space 128
s2: .space 128
greater: .ascii "First string is greater than the second string\n\0"
lesser: .ascii "First string is lesser than the second string\n\0"
equal: .ascii "Both the strings are equal\n\0"

.end
