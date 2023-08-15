.global input
.extern strlen
.global list1
.global list2
.global size1
.global size2

.align 2
.text
input:	mov r11,lr

	ldr r0,=duplicate
	bl output_string
	bl output_new_line
	bl input_number
	str r0,[sp,#12]!
	sub sp,sp,#12
	
	ldr r0,=choice
	bl output_string
	bl output_new_line
	bl input_number
	str r0,[sp,#8]!
	sub sp,sp,#8
	
	ldr r0,=len1
	bl output_string
	bl output_new_line
	bl input_number		@input num 1
	str r0,[sp,#-4]!
	mov r4,r0			@r4 contains size of list1
	
	ldr r0,=len2
	bl output_string
	bl input_number
	str r0,[sp,#-4]!		@input num 2
	mov r9,r0			@r9 contains size of list2
		
	add r1,r4,r9
	str r1,[sp,#12]!
	sub sp,sp,#12
	
	mov r5, #0             @ loop variable
    	ldr r7,=space1         @ will store pointers here
    	ldr r6,=list1
    	ldr r8,=size1
    	mov r10,#0		@flag
    	
    		
take:   cmp r5, r4
        beq out
        
        ldr r0,=prompt
        bl output_string
        bl output_new_line
        
        mov r0,r7
	bl input_string
	str r7,[r6]
	mov r0,r7
	bl strlen
	sub r0,r0,#1
	str r0,[r8]
	add r6,r6,#4
	add r8,r8,#4
        add r7, r7, #104
         
	add r5,r5,#1
	b take
	
out:	add r10,r10,#1
	mov r5, #0             @ loop variable
    	ldr r7,=space2         @ will store pointers here
    	ldr r6,=list2
    	ldr r8,=size2
    	mov r4,r9
	cmp r10,#1	
	beq take
	
	
	ldr r3,=list1
	str r3,[sp,#-4]!
	ldr r3,=size1
	str r3,[sp,#-4]!
	ldr r3,=list2
	str r3,[sp,#-4]!
	ldr r3,=size2
	str r3,[sp,#-4]!
	
	mov pc,r11
	
	
.data
operands: .word 0, 0, 0
list1: .space 10000
list2: .space 10000
size1: .space 10000
size2: .space 10000
space1:.space 10000
space2:.space 10000
l1: .ascii "Enter list 1\n\0"
l2: .ascii "Enter list 2\n\0"
len1: .ascii "Enter the length of list 1\n\0"
len2: .ascii "Enter the length of list 2\n\0"
choice: .ascii "Enter 1 for case sensitive comparison and 0 for case insensitive\n\0"
duplicate: .asciz "To remove duplicate entries, press 1, otherwise press 0"
prompt: .asciz "Enter a string"
.end
