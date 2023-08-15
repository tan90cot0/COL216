.global branch
.global merge
.extern exit
.extern comp2str
.text
merge: b comp2str			@present in compare file

branch:cmp r3,#1
	beq second
	cmp r3,#0
	beq third
	
first:	add sp,sp,#12			@execute if first string lesser
	ldr r3,[sp]			@r3 contains the current word
	ldr r9,[r3]
	ldr r8,[sp,#12]!		@getting the address of the list pointer
	str r9,[r8]			@storing the current string in the final list
	add r8,r8,#4			@storing the pointer to the next empty space in the list
	str r8,[sp]
	sub sp,sp,#24
	
	ldr r6,[sp,#20]!
	sub r6,r6,#1
	str r6,[sp]
	sub sp,sp,#20
	cmp r6,#0
	beq decide
	
	add sp,sp,#12
	add r3,r3,#4			@storing the pointer to the next word
	str r3,[sp]
	sub sp,sp,#12
	
	ldr r3,[sp,#8]!		@storing the size of the next element
	add r3,r3,#4
	str r3,[sp]
	sub sp,sp,#8
	
	mov r4,#0
	b comp2str
	
second: @mov r0,#69
	@bl output_number
	add sp,sp,#4			@execute if second string lesser
	ldr r3,[sp]			@r3 contains the pointer to the current word

	add sp,sp,#20
	ldr r9,[r3]
	ldr r8,[sp]			@getting the address of the list pointer
	str r9,[r8]			@storing the current string in the final list
	add r8,r8,#4			@storing the pointer to the next empty space in the list
	str r8,[sp]
	sub sp,sp,#24
	
	
	ldr r5,[sp,#16]!
	sub r5,r5,#1
	str r5,[sp]
	sub sp,sp,#16
	cmp r5,#0
	beq decide
	
	add sp,sp,#4			@storing the pointer to the next string
	add r3,r3,#4
	str r3,[sp]
	sub sp,sp,#4
	
	ldr r3,[sp]			@storing the size of the next string
	add r3,r3,#4
	str r3,[sp]
	
	mov r4,#0
	
	b comp2str

decide:
	@mov r0,#24
	@bl output_number
	ldr r6,[sp,#20]!
	sub sp,sp,#20				
	cmp r6,#0
	bne remove1				@first non-empty, second empty
	ldr r5,[sp,#16]!			
	sub sp,sp,#16
	cmp r5,#0
	bne remove2				@first empty, second non-empty
	b exit					@both empty
	
remove1:mov r0,lr
	add sp,sp,#12			@execute if first string lesser
	ldr r3,[sp]			@r3 contains the current word
	ldr r9,[r3]
	ldr r8,[sp,#12]!		@getting the address of the list pointer
	str r9,[r8]			@storing the current string in the final list
	add r8,r8,#4			@storing the pointer to the next empty space in the list
	str r8,[sp]
	sub sp,sp,#24
	
	add sp,sp,#12
	add r3,r3,#4			@storing the pointer to the next word
	str r3,[sp]
	sub sp,sp,#12
	
	ldr r3,[sp,#8]!		@storing the size of the next element
	add r3,r3,#4
	str r3,[sp]
	sub sp,sp,#8
	
	ldr r6,[sp,#20]!
	sub r6,r6,#1
	str r6,[sp]
	sub sp,sp,#20
	b decide

remove2: @mov r0,#66
	@bl output_number
	add sp,sp,#4			@execute if second string lesser
	ldr r3,[sp]			@r3 contains the pointer to the current word

	add sp,sp,#20
	ldr r9,[r3]
	ldr r8,[sp]			@getting the address of the list pointer
	str r9,[r8]			@storing the current string in the final list
	add r8,r8,#4			@storing the pointer to the next empty space in the list
	str r8,[sp]
	sub sp,sp,#24
	
	add sp,sp,#4			@storing the pointer to the next string
	add r3,r3,#4
	str r3,[sp]
	sub sp,sp,#4
	
	ldr r3,[sp]			@storing the size of the next string
	add r3,r3,#4
	str r3,[sp]
	
	ldr r5,[sp,#16]!
	sub r5,r5,#1
	str r5,[sp]
	sub sp,sp,#16

	b decide
	
third:	ldr r0,[sp,#36]!
	sub sp,sp,#36
	cmp r0,#0  
	beq here
	ldr r0,[sp,#28]!
	sub r0,r0,#1
	str r0,[sp]
	sub sp,sp,#28
	bl remove4
here:	bl remove3

	ldr r6,[sp,#20]!
	sub sp,sp,#20	
	mov r0,#0			
	cmp r6,#0
	beq if1				@first non-empty, second empty
	add r0,r0,#1
if1:	ldr r5,[sp,#16]!			
	sub sp,sp,#16
	cmp r5,#0
	beq if2
	add r0,r0,#1
if2:	cmp r0,#2
	beq comp2str	
	b decide				@both empty	


remove3:
	mov r0,lr
	add sp,sp,#12			@execute if first string lesser
	ldr r3,[sp]			@r3 contains the current word
	ldr r9,[r3]
	ldr r8,[sp,#12]!		@getting the address of the list pointer
	str r9,[r8]			@storing the current string in the final list
	add r8,r8,#4			@storing the pointer to the next empty space in the list
	str r8,[sp]
	sub sp,sp,#24
	
	add sp,sp,#12
	add r3,r3,#4			@storing the pointer to the next word
	str r3,[sp]
	sub sp,sp,#12
	
	ldr r3,[sp,#8]!		@storing the size of the next element
	add r3,r3,#4
	str r3,[sp]
	sub sp,sp,#8
	
	ldr r6,[sp,#20]!
	sub r6,r6,#1
	str r6,[sp]
	sub sp,sp,#20
	mov pc,r0
	
remove4: mov r0,lr
	add sp,sp,#4			@execute if second string lesser
	ldr r3,[sp]			@r3 contains the pointer to the current word			
	add r3,r3,#4
	str r3,[sp]			@storing the pointer to the next string
	sub sp,sp,#4
	
	ldr r3,[sp]			@storing the size of the next string
	add r3,r3,#4
	str r3,[sp]
	
	ldr r5,[sp,#16]!
	sub r5,r5,#1
	str r5,[sp]
	sub sp,sp,#16
	mov pc,r0
	

