; program to count the no of vowels
.MODEL SMALL
.STACK 100H
.DATA
	X DB 'Harry Potter and the Order of the Phoenix$' ; 12 vowels
	BASE DW 10
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	
	LEA SI,X
	INC CX
L1:
	MOV AL,[SI]
	CMP AL,'$'
	JE L3 ; go to print
	CMP AL,'A'
	JE L2
	CMP AL,'E'
	JE L2
	CMP AL,'I'
	JE L2
	CMP AL,'O'
	JE L2
	CMP AL,'U'
	JE L2
	CMP AL,'a'
	JE L2
	CMP AL,'e'
	JE L2
	CMP AL,'i'
	JE L2
	CMP AL,'o'
	JE L2
	CMP AL,'u'
	JE L2
	INC SI
	JMP L1
L2:
	INC CX
	INC SI
	JMP L1
L3:
	MOV DX,'$' ;prepare for printing the ans by using stack
	PUSH DX
	MOV CH,0 ;clear ch high bit
	MOV AX,CX ;cx is the ans
	MOV BX,BASE ; bx = 10
L4:	
	MOV DX,0
	DIV BX
	PUSH DX
	CMP AX,0
	JE L5
	JMP L4
L5:
	POP DX
	CMP DX,'$'
	JE L6
	ADD DX,48
	MOV AH,02H
	INT 21H
	JMP L5
L6:
	MOV AH,4CH
	INT 21H
MAIN ENDP
END MAIN