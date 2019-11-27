.MODEL SMALL
.STACK 100H
.DATA
	text db "YEAH$"
	filename db "la.txt",0
.CODE
MAIN PROC

MOV AX,@DATA
MOV DS,AX
			; create file
mov	ah,3ch
mov	cx,0
lea	dx,filename
int	21h			
			; write string to file
mov	BX,AX
mov	cx,5
lea	dx,text
mov	ah,40h
int	21h

mov	ah,4ch
int	21h

MAIN ENDP
END MAIN