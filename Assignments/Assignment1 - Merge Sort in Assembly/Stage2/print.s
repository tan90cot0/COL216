.global less
.global great
.global eq
.global exit
.global params
.extern list
.text

@registers used
@r0
less: 
	mov r3,#-1
	b branch

great:  
	mov r3,#1
	b branch

eq:  	mov r3,#0
	b branch
	
exit:	ldr r8,=list 

	add sp,sp,#28
	ldr r9,[sp]
	sub sp,sp,#28
	mov r5,#0					@r6 is the loop counter
	bl output_new_line
	bl output_new_line
	bl output_new_line
	ldr r0,=sz
	bl output_string
	mov r0,r9
	bl output_number
	bl output_new_line
	ldr r0,=sorted
	bl output_string
loop:	cmp r9,r5
	beq out

	ldr r0,[r8]
	bl output_string
	bl output_new_line
	add r8,r8,#4
	add r5,r5,#1
	b loop
	
out:	mov r0,#0x18
	swi 0x123456
	
flag: 	ldr r0,= error					@error message to debug
	bl output_string

.data
greater: .ascii "First string is greater than the second string\n\0"
lesser: .ascii "First string is lesser than the second string\n\0"
equal: .ascii "Both the strings are equal\n\0"
sorted: .asciz "Sorted List:\n"
sz: .asciz "The size of the sorted list is: "
error: .ascii"flag\n\0"

.end
