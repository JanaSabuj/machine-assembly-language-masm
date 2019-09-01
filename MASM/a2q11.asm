.model small
.stack 100h

.data
bytes dd 0040004ch
rows db ?
cols db ?
msg1 db 0ah,0dh,"Total number of rows(in hex) = ",'$'
msg2 db 0ah,0dh,"Total number of columns(in hex) = ","$"
msg3 db 0ah,0dh,"Press any key to clear screen","$"
hexcode db '0123456789ABCDEF'

.code
display proc
	push ax
	push bx
	push cx
	push dx
	lea dx,msg1	;display msg1
	mov ah,09h
	int 21h
	mov al,rows	;al=no of rows
	mov cl,10h
	mov ah,00h
	div cl		;al=quotient, ah=remainder
	mov bl,al
	mov dl,hexcode[bx]
	push ax
	mov ah,02h	;display char to standard output device
	int 21h
	pop ax
	mov bl,ah
	mov dl,hexcode[bx]
	mov ah,02h	;display char to standard output device
	int 21h
	lea dx,msg2	;display msg2
	mov ah,09h
	int 21h
	mov al,cols	;al=no of cols
	mov cl,10h
	mov ah,00h
	mov bh,00h
	div cl		;al=quotient ah=remainder
	mov bl,al
	mov dl,hexcode[bx]
	push ax
	mov ah,02h	;display char to standard output device
	int 21h
	pop ax
	mov bl,ah
	mov dl,hexcode[bx]
	mov ah,02h
	int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	ret
display endp		;end display procedure

main proc
	mov ax,@data
	mov ds,ax
	mov ah,0fh
	int 10h
	mov cols,ah	;ah=no of cols on screen
	mov cl,ah
	mov ch,0
	push ds
	lds si,bytes
	mov ax,[si]	;ax=total no of bytes on video page
	pop ds
	shr ax,1	;divides ax by 2 to get total number of characters on page
	div cl
	mov rows,al
	call display
	lea dx,msg3
	mov ah,09h
	int 21h
	mov ah,01h	;input character from standard input device and echo to standard output device
	int 21h
	mov dh,0	;initialise row coordinate to 0 again
again:	mov bh,0	;bh=page 0
	mov dl,0	;initialise column coordinate to 0
	mov ah,02h	;set cursor position to (dl,dh)
	int 10h
	mov bl,0	;colour (set foreground and background to same colour)
	mov al,'X'	;char to be displayed
	mov ah,09h	;write char at cursor position
	int 10h
	inc dh		;increase row coordinate by one position
	cmp dh,rows
	jb again
	mov ah,4ch	;exit
	int 21h
main endp
end main