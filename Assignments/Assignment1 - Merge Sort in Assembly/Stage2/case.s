.extern compare
.global lower1


@external registers used - 
@r5 - for character 1
@r6 - for character 2
lower1:  	cmp r5,#65
		bge upper1
lower2:	cmp r6,#65
		bge upper2
upper1: 	cmp r5,#90
	  	bgt l1
	  	add r5,r5,#32
l1:	  	b lower2
upper2: 	cmp r6,#90
	  	bgt l2
	  	add r6,r6,#32
l2:	  	b compare
