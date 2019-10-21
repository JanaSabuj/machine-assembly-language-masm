; program to find the gcd of two numbers
dosseg
.model small
.stack 100h
.data
	str1 db '$'
	BASE dw 10
.code
main proc

MOV AX,121 ;no1
MOV BX,242 ;no2

GCD:
XOR DX,DX
;AX
DIV BX
MOV AX,BX
MOV BX,DX
CMP BX,0
JNE GCD

; -------------------------NOTE NOW GCD IS CONTAINED IN AX -----------------------------

	MOV CX,'$' ;preparation for printing the min no by using stack
	PUSH CX
	MOV BX,10 ;bx = 10 - do not move base here
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



 
main endp
end main

