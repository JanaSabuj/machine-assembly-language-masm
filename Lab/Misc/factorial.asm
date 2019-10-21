dosseg
.model small
.stack 100h
.data
	ANS DB ?
.code
main proc

MOV AX,@DATA
MOV DS,AX

MOV AL,5
MOV BL,4

L1:
MUL BL
SUB BL,1
LOOP L1

MOV ANS,AL

main endp
end main
