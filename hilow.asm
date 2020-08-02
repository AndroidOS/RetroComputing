;Find highest and lowest number in array in Z80 assembly for the VZ200 z1 - b1
		.org 32256
		
		call 01C9h	;clear screen
		
		LD A,00h ;set screen ouput
		LD (789Ch),A 
	
		LD HL,headingMesg 
		call 2B75h ;display mesg string
		
		LD HL,subHead ;display array->
		call 2B75h 
		
		ld ix,array ;print initial array
		call printArray
		call addReturn
		
		call findHighest
		ret
		
printNums:
		push bc
		ld hl,postHead1
		call 2B75h
		pop bc	
		ld l,b
		ld h,0
		push bc
		call 0FAFh
		call addReturn
		call addReturn
		ld hl,postHead2
		call 2B75h
		pop bc
		ld l,c
		ld h,0
		call 0FAFh
		call addReturn
		ret	
		
findHighest:
		ld ix,array
		ld b,0
hiLoop:
		ld a,(ix)
		inc ix
		cp 255
		jp z,endHiLoop
		
		cp b
		jp nc,higher
returnHigh:	
		cp c
		jp c,lower
returnLow:		
		jp hiLoop
endHiLoop:
		call printNums
		ret
higher:
		ld b,a
		jp	returnHigh
lower:
		ld c,a
		jp returnLow



		
printArray:
		;LD HL,subHead 
		;call 2B75h 
		ld a, '['
		call 033ah
		ld a, ' '
		call 033ah
		;ld ix, array
		
_loop1
		ld h,0
		ld l,(ix)
		inc ix
		;ld a,l
		
		ld a,l
		cp 255
		jp z,_loopEnd
		push hl
		call 0FAFh	
		
		ld a, ' '
		call 033ah
		pop hl
		jp _loop1
_loopEnd
		ld a, ']'
		call 033ah
		ret


		
addReturn:
		LD A,0dh 
		CALL 033AH ;and display 
		ret
		
addSpace:
		LD A,' ' 
		CALL 033AH ;and display 
		ret
	
subHead: 	
		.byte "ARRAY-> ",0
		

		
postHead1:
		.byte "LARGEST NUMBER  = ",0
postHead2:
		.byte "SMALLEST NUMBER = ",0	

headingMesg:
		.byte "VZ200 Z80 ARRAY HIGHEST LOWEST "
		.byte 0dh," NUMBERS"
		.byte 0dh
		.byte 0dh
		.byte 00h 
		
array: 	.byte 78, 2, 67, 21, 3, 81, 1,16,255 ;255 end array 


		.end