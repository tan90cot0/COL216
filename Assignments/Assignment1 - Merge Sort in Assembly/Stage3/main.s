.extern sort
.text
	bl input				@r5 contains the length, list contains the pointer
						@r3 contains remove duplicates, r10 contains case
	
	
	@inputs of sort are r5 and r8, result is also in r5 and r8
	bl sort
	
	bl output_new_line
	bl output_new_line
	bl output_new_line
	ldr r0,=sz
	bl output_string
	mov r0,r5
	bl output_number
	bl output_new_line
	ldr r0,=sorted
	bl output_string
		
	mov r4,#0					@loop variable

loop:  cmp r5,r4
	beq exit
		
	ldr r0,[r8]
	add r8,r8,#4
	bl output_string
	bl output_new_line
	
	add r4,r4,#1
	b loop
	
exit:	mov r0,#0x18
	swi 0x123456

	
.data
operands: .word 0, 0, 0

sorted: .asciz "Sorted List:\n"
sz: .asciz "The size of the sorted list is: "
.end
