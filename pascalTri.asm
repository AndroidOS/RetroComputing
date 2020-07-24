		;b1
		;Bubble sort in Z80 assembly for the VZ200 
		.org 32256

		CALL 01C9h	;clear screen
		
		LD A,00h ;set screen ouput
		LD (789Ch),A 
	
		LD HL,headingMesg 
		CALL 2B75h ;display mesg string
		
		LD HL,preMesg 
		CALL 2B75h ;display mesg string
		
		
		call sizeLoop
		ret

sizeLoop:
		ld e, 5 ;pyramid size 5 (maximum for single digits)
sLoop1:	
		call addSpaces
		call printLine
		call checkLine
		dec e
		jp nz,sLoop1
		ret
		

		;CALL 0FAFh ; display hl	
		
checkLine:
		ld iy, line1 ;source
		ld ix, line2 ;destination
		ld a, 1
		ld (ix),a ;add dest line start 1
		inc ix
		ld b,(iy) ;get first digit
		inc iy
checkLoop:
		ld a,(iy) ;get next source digit
		cp 0
		jp z,checkEnd ;is it 0 then end
		ld d,a
		add a,b
		ld (ix),a ;put result in dest.
		ld b,d
		inc ix
		inc iy
		
		jp checkLoop
checkEnd:
			ld a,1
			ld (ix),a
		ret

		
addSpaces:
		ld ix,spaces
		ld c,(ix)
		ld a, ' '
sLoop:	
		call 033ah
		dec c
		jp nz, sLoop
		ld ix,spaces
		ld a,(ix)
		dec a
		ld (ix),a
		ret
		
printLine:
		push bc
		ld hl, line2
		ld ix, line1
lineLoop:
			ld a,(hl)
			ld (ix),a ;copy line 2 to line 1
			cp 0
			jp z, lineEnd
			add a, 48
			call 033ah
			inc hl
			inc ix
			jp lineLoop
lineEnd:
		call addReturn		
		pop bc
		ret
		
printLine1:
		push bc
		ld hl, line1
		;ld ix, line1
lineLoop1:
			ld a,(hl)
			;ld (ix),a ;copy line 2 to line 1
			cp 0
			jp z, lineEnd
			add a, 48
			call 033ah
			inc hl
			;inc ix
			jp lineLoop1
lineEnd1:
		call addReturn		
		pop bc
		ret
		
addReturn:
		LD A,0dh 
		CALL 033AH ;and display 
		ret


preMesg: .byte    "TRIANGLE SIZE: 5 "
		 .byte 0dh
		 .byte 0dh
		 .byte 00h
		 
spaces: .byte 0eh

line1:  .byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
line2:  .byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		 

headingMesg:
		.byte "  VZ200 Z80 PASCAL'S TRIANGLE "
		.byte 0dh
		.byte 0dh
		.byte 00h 
		
		.end