dosseg
.model small
.stack 100h
.data
	var1 db 'S'
	var2 db ?
	var3 db 'greenindia$'
.code
main proc

mov ax,@data
mov ds,ax

mov dl,var1
mov ah,2
int 21h

mov dl,10
mov ah,2
int 21h

mov dl,13
mov ah,2
int 21h

mov var2,'D'
mov dl,var2
mov ah,2
int 21h

mov dl,10
mov ah,2
int 21h

mov dl,13
mov ah,2
int 21h

mov dx, offset var3

mov ah,9
int 21h

mov ah,4ch
int 21h

main endp
end main