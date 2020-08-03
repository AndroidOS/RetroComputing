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
		
		LD HL,postHead1 ;display test number
		call 2B75h 
		call printTestNum
		
		LD HL,lineHeading ;display asterix line
		call 2B75h 
		
		LD HL,postHead2 ;display pairs heading
		call 2B75h 
		
		call testPairs
		call addReturn
		
		
		ret
		
testPairs:
		ld ix,array ;test number
		ld iy,array ;loop array
getTestNum:
		ld c,(ix)
		ld a,c
		cp 255
		jp z,endSub
testLoop:
		ld b,(iy)
		inc iy
		ld a,b
		cp 255
		jp z,endTest
		ld a,c
		SCF ;; set carry flag
		CCF ;; complement carry flag
		add a,b
		cp 42
		jp z, outPairs
loopRet:
		jp testLoop
endTest:
		inc ix
		jp getTestNum
endSub:
		ret
		
outPairs:
		push bc
		ld h,0
		ld l,b
		push bc
		ld a, '['
		call 033ah
		call 0FAFh
		call addSpace
		pop bc
		ld h,0
		ld l,c
		call 0FAFh
		ld a, ']'
		call 033ah
		call addSpace
		pop bc
		jp 	loopRet
		
		
		
		
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

printTestNum:
		ld hl,testNum
		ld a,(hl)
		ld l,a
		ld h,0
		call 0FAFh
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
		.byte "ARRAY ",0
		
lineHeading:
		.byte 0dh,"****************"
		.byte "****************",0
		
postHead1:
		.byte 0dh, "TEST NUMBER  = ",0
postHead2:
		.byte 0dh,"PAIRS ARE:  ",0dh,0	

headingMesg:
		.byte "VZ200 Z80 FIND SUM PAIRS FOR "
		;.byte "TEST"
		.byte 0dh,"TEST NUMBER"
		.byte 0dh
		.byte 0dh
		.byte 00h 
		
array: 	.byte 31, 2, 40, 11,16, 26, 1,41,255 ;255 end array 

testNum: .byte 42
		.end








;5. How to find all pairs on integer array whose sum is equal
;to given number? (solution)
;This is an intermediate level of array coding question,
;it's neither too easy nor too difficult. 
;You have given an integer array and a number, 
;you need to write a program to find all elements 
;in the array whose sum is equal to the given number. 
;Remember, the array may contain both positive and 
;negative numbers, so your solution should consider that. 
;Don't forget to write unit test though, even if the interviewer is not asked for it, that would separate you from a lot of developers. Unit testing is always expected from a professional developer.



;Read more: https://javarevisited.blogspot.com/2015/06/top-20-array-interview-questions-and-answers.html#ixzz6Tm8584v1