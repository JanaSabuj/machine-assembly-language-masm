; program to print the uppercase string
.MODEL SMALL
.STACK 100H
.DATA
	X DB 20 DUP(?)
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	
	LEA SI,X ;set the array pointer
L1:
	MOV AH,01H ;take input of the element
	INT 21H 
	CMP AL,13
	JE L2 ;go to the end to print the uppercase string
	CMP AL,97
	JGE L3 ; if ascii>97, it is lowercase and have to be dealt with
	JMP L4 ; common for all, append to the array
L3:
	CMP AL,122
	JLE L5 ; if a-z
	JMP L4
L5:
	SUB AL,32
L4:
	MOV [SI],AL
	INC SI
	JMP L1
L2:
	MOV CL,'$' ;append a '$' to the string and print it
	MOV [SI],CL
	LEA DX,X
	MOV AH,09H
	INT 21H
	MOV AH,4CH
	INT 21H
MAIN ENDP
END MAIN