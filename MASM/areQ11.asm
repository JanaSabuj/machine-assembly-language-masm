.model small
.stack 100h
.code
main proc
	mov al, 13h
	mov ah, 0
	int 10h     ; set graphics video mode. 
	
	mov al, 00h
	mov bh, 1100b 	;code for black
	mov ah, 07h
	mov cx, 0		;(x,y) of the top left corner
	mov dh, 70		;(x,y) of bottom right corner
	mov dl, 70
	int 10h
	
	;mov al, 03h
	;mov ah, 0
	;int 10h
	
	mov ah, 4ch
	int 21h
main endp
end main