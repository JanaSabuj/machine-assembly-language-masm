; program to find the min of the array
.MODEL SMALL
.STACK 100H
.DATA
	ARR DW 321,34,112,565,123,323,112,45,13,34,'$' ;
	BASE DW 10
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	
	LEA SI,ARR
	MOV AX,[SI] ;1ST ELEMENT MOVED TO AX
	INC SI 
	INC SI ; twice incremented due to dw
	MOV CX,9 ;loop through the remaining 9 elements
L1:
	CMP AX,[SI]
	JL L2 ; if min < arr[i], then just i++
	MOV AX,[SI] ;else update the min = arr[i]
L2:
	INC SI
	INC SI
	LOOP L1
	
	MOV CX,'$' ;preparation for printing the min no by using stack
	PUSH CX
	MOV BX,BASE ;bx = 10
L3:
	MOV DX,0 ;note, AX has the min no
	DIV BX
	
	ADD DX,48
	PUSH DX ;push the remainder to stack
	CMP AX,0 ;compare quotient
	JE L4
	JMP L3
L4:
	POP DX
	CMP DX,'$'
	JE L5
	MOV AH,02H
	INT 21H
	JMP L4
L5:
	MOV AH,4CH
	INT 21H
MAIN ENDP
END MAIN