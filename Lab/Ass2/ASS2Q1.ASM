; program to add two 16-bit numbers
.MODEL SMALL
.STACK 100H
.DATA
	NUM1 DW 12001 ;pos no
	NUM2 DW -22001 ;neg no
	BASE DW 10
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	
	MOV AX,NUM1
	ADD AX,NUM2
	MOV CX,AX ;move to CX 
	CMP CX,0 ;compare
	JGE L1 ;if positive, jump to L1
	
	MOV AX,CX ; come here if the sum is negative
	NEG AX
	MOV CX,AX
	MOV DX,'-'; print the minus '-' sign
	MOV AH,02H
	INT 21H
	
L1:
	MOV DX,'$' ; this prepares for the stack based approach to print a no stored in CX
	PUSH DX ; end of stack indicated by '$'
	MOV BX,BASE ;bx contains 10
L2:
	MOV AX,CX
	MOV DX,0
	
	DIV BX
	
	MOV CX,AX
	PUSH DX
	
	CMP CX,0
	JE L3 ;if end reached, go to l3
	JMP L2 ;else loop again
L3:
	POP DX
	CMP DX,'$'
	JE L4 ; if end of stack is reached, jump to the exit xondition
	ADD DX,48 
	MOV AH,02H ; print the single digit
	INT 21H
	JMP L3
L4:
	MOV AH,4CH
	INT 21H
MAIN ENDP
END MAIN