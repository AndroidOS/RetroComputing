;Find duplicate in array in Z80 assembly for the VZ200 z1 - b1
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
		
		call findDup
		
		ld hl,postHead1
		call 2B75h 
		
		ld ix,buffer ;print answer array
		call printArray
		
		call addReturn
		ret
		
findDup:
		ld iy,array
_init
		ld ix,array
		ld c,0
		ld b,(iy) ; b is outer loop number under test
		ld a,99
		cp b
		jp z,_endLoop
		inc iy
_loop:	ld a,(ix) ; a is testing loop
		cp 99
		jp z,_endInner
		
		cp b
		jp z,_addCount
		ld a,c
		cp 2
		jp nc,more2
		
_retLoop:
		inc ix
		jp _loop	
_endInner:
		ld c,0
		jp _init
_endLoop		
		ret
		
_addCount
		inc c
		jp _retLoop
		
		
more2:
		ld hl,buffer
_buffLoop:
		ld a,(hl)
		inc hl
		cp b
		jp z,_endBuff
		cp 99
		jp nz,_buffLoop
		dec hl
		ld (hl),b
		inc hl
		ld (hl),99
_endBuff:		
		jp _retLoop	


		
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
		cp 99
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
		.byte "DUPLICATES-> ",0
		
postHead:
		
		.byte 0dh
		.byte 0dh
		.byte 00h 

headingMesg:
		.byte "VZ200 Z80 ARRAY DUPLICATE "
		.byte "FINDER"
		.byte 0dh
		.byte 0dh
		.byte 00h 
		
array: 	.byte 6, 2, 3, 2, 3, 4, 5, 5,3,16,99 ;99 end array 
buffer: .byte 99,0,0,0,0,0,0,0,0,0,0,0,0

		.end