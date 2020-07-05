;Run Length Encoding in Z80 assembly for the VZ200 
		.org 32256

		CALL 01C9h	;clear screen
		
		LD A,00h ;set screen ouput
		LD (789Ch),A 
	
		LD HL,headingMesg 
		CALL 2B75h ;display mesg string
		
		LD HL,preMesg 
		CALL 2B75h ;display mesg string
	
		call dispStringRaw
		call startRle
		
		LD HL,postMesg 
		CALL 2B75h ;display mesg string
		call dispStringRLE
		
		ret
		
startRle:
		ld iy, stringRaw 
		ld ix, stringRLE
newCount:
		ld c,0
startLoop:
		ld a, (iy)
		cp 0  ;check for end of raw string
		jp z,endProc
		ld h,a
		inc c
		inc iy
		ld a, (iy)
		cp h
		jp z, startLoop
		jp endTotal
return:		
		jp nz, newCount
endProc:	
		ret
endTotal:
		ld a,c
		add a,48
		ld (ix), a ;add number of repetitions to RLE string
		inc ix
		ld (ix), h ;add test character to RLE string
		inc ix
		jp return	
		
dispStringRaw:
		LD HL,stringRaw 
		call 2B75h ;display mesg string
		ret

dispStringRLE:
		LD HL,stringRLE 
		call 2B75h ;display mesg string
		ret		

	
stringRaw: 	.byte "AAAABBBCCDAA"
		.byte 00h
		
stringRLE: 	                  
		.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		.byte 00h

preMesg: .byte "RAW STRING : "
		 .byte 0dh
		 .byte 00h
		 
postMesg: .byte 0dh
		  .byte 0dh
		 .byte "RLE STRING : "
		 .byte 0dh
		 .byte 00h

headingMesg:
		.byte "VZ200 Z80 RUN LENGTH ENCODING "
		.byte 0dh
		.byte 0dh
		.byte 00h 	

		.end