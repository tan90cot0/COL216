.global input
.extern strlen
.align 2
.text
input:	stmfd sp!, {lr}


	ldr r0,=len
	bl output_string
	bl output_new_line
	bl input_number
	mov r5,r0				@len
	
	ldr r0,=choice
	bl output_string
	bl output_new_line
	bl input_number
	mov r10, r0				@case
	
	ldr r0,=duplicate
	bl output_string
	bl output_new_line
	bl input_number
	mov r9, r0				@duplicates
	
	mov r4, #0             @ loop variable
    	ldr r7,=space         @ will store pointers here
    	ldr r6,=list  	
    		
take:   cmp r5, r4
        beq out
        
        ldr r0,=prompt
        bl output_string
        bl output_new_line
        
        mov r0,r7
	bl input_string
	str r7,[r6]
	add r6,r6,#4
        add r7, r7, #104
         
	add r4,r4,#1
	b take
	
out:	
	ldr r8,=list
	mov r3,r9
	ldmfd sp!,{pc}
	
	
.data
operands: .word 0, 0, 0
space: .space 20000
list: .space 10000
len: .asciz "Enter the length of list\n"
choice: .ascii "Enter 1 for case sensitive comparison and 0 for case insensitive\n\0"
duplicate: .asciz "To remove duplicate entries, press 1, otherwise press 0"
prompt: .asciz "Enter a string"

.end
