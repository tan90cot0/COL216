.global comp2str
.global compare
.extern lower1
.extern eq
.extern less
.extern great
.extern here
@external registers used-
@r10
@r9
@r4
@r7

comp2str:
	ldr r3,[sp]
	ldr r9,[r3]
	add sp,sp,#8	
	ldr r3,[sp]
	ldr r10,[r3]
	sub sp,sp,#8
	mov r7,#0
	cmp r10,r4			@r10 contains the length of string 1 and r4 is the iteration counter
	beq cond1
	b second 			
	
check:
	add sp,sp,#4
	ldr r3,[sp]
	ldr r6,[r3]
	add sp,sp,#8
	ldr r3,[sp]
	ldr r5,[r3]
	sub sp,sp,#12
	add r5,r5,r4
	ldrb r5,[r5]
	add r6,r6,r4
	ldrb r6,[r6]
	
	ldr r0,[sp,#32]!
	sub sp,sp,#32
	cmp r0,#0
	beq lower1			@the file case contains case5 - need r5,r6
	
compare:cmp r5,r6
	bne not
	add r4,r4,#1
	b comp2str
		
not:	cmp r5,r6	
	blt less
	b great

second: 
	cmp r9,r4
	beq cond2
	b end
	
cond1:  add r7,r7,#1
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
