		;Bubble sort in Z80 assembly for the VZ200 
		.org 32256

		CALL 01C9h	;clear screen
		
		LD A,00h ;set screen ouput
		LD (789Ch),A 
	
		LD HL,headingMesg 
		CALL 2B75h ;display mesg string
		
		LD HL,preMesg 
		CALL 2B75h ;display mesg string
	
		call dispArray
		
		call sortArray
		
		LD HL,postMesg 
		CALL 2B75h ;display mesg string
	
		call dispArray
		call addReturn
		ret
		
sortArray:
		ld iy, array
		ld hl, counter
		ld c, (hl)
		ld a, (iy)
		inc iy
loopArray:
		ld b, (iy)
		cp b
		jp nc,exchange
loopReturn:
		ld a,b
		inc iy
		dec c
		jp nz, loopArray
		ld a, (hl)
		dec a
		ld (hl), a
		
		jp nz, sortArray
		ret
exchange:
		ld (iy),a
		dec iy
		ld (iy),b
		inc iy
		ld b, a
		jp loopReturn
		
dispArray:
		push iy
		push bc
		push de
		push hl
		ld iy, array
		ld c, 6
arrayLoop:
		push bc
		
		ld a, (iy)
		ld de, tmp
		ld (de), a
		ld hl, (tmp)
	
		
		;ld hl, 5
		CALL 0FAFh ; display hl	
		
		pop bc
		inc iy
		call addComma
		dec c
		 
		jp nz, arrayLoop
		pop hl
		pop de
		pop bc
		pop iy
		ret
		
addComma:
		LD A,' ' ;load reg A with code ',' 
		CALL 033AH ;and display 
		ret
		
addReturn:
		LD A,0dh 
		CALL 033AH ;and display 
		ret
	
	
array 	.byte 80,35,54,21,13,30

preMesg: .byte    "UNSORTED ARRAY: "
		 .byte 0dh
		 .byte 00h
		 
postMesg: .byte 0dh
		  .byte 0dh
		 .byte "SORTED ARRAY  : "
		 .byte 0dh
		 .byte 00h

headingMesg:
		.byte "VZ200 Z80 BUBBLE SORT "
		.byte 0dh
		.byte 0dh
		.byte 00h 
		
tmp 	.byte 0
		.byte 0
		
counter  .byte 5

		.end