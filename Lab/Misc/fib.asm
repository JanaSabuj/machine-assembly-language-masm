; PROGRAM TO PRINT THE N-TH FIBONACCI NUMBER
dosseg
.model small
.stack 100h
.data
.code
main proc

; 0 1 1 2 3 5 8 13 21 34

MOV BX,0
MOV DX,1
MOV CX,7; 7 = N-2

; BX DX BX+DX

FIB:
ADD BX,DX
MOV AX,BX
MOV BX,DX
MOV DX,AX
MOV AX,DX
LOOP FIB

MOV AX,DX
; -------------------------NOTE NOW FIB-NO IS CONTAINED IN AX -----------------------------

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
