.model small
.stack 100h

.code
main proc

	mov al, 03h
	mov ah, 0
	int 10h     ; set graphics video mode. 
	;mov al, 13h
	;mov ah, 0
	;int 10h     ; set graphics video mode. 
	
	;mov al, 1100b
	;mov cx, 10
	;mov dx, 20
	;mov ah, 0ch
	;int 10h     ; set pixel.
	
	mov ah, 4ch
	int 21h
main endp
end main