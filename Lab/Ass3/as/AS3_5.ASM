.MODEL SMALL
.STACK 100H
.DATA
	msg db "lakshya",'$'
.CODE
MAIN PROC
mov ax,@data
mov ds,ax

MOV CX,0098H
MOV DX,9680H

MOV AH,86H
INT 15H

MOV DX,0
LEA DX,MSG
MOV AH,09H
INT 21H

mov ah,4ch
int 21h

MAIN ENDP
END MAIN