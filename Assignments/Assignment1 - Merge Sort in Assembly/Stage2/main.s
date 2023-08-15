.extern input
.global list
.extern params
.align 2
@registers used-
@r4 - loop counter

.text
	mov r0,#0
	str r0,[sp,#-4]!			@storing space for duplicate
	str r0,[sp,#-4]!			@storing space for comparison
	str r0,[sp,#-4]!			@storing space for sum of list lengths
	ldr r8,=list
	str r8,[sp,#-4]!
	bl input
	mov r4,#0
	b merge
	
.data
list: .space 20000


.end
