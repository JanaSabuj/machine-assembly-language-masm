dosseg
.model small
.stack 100h
.data
	var1 db 'hello$'
	var2 db 'greenindia$'
.code
main proc

mov ax,@data
mov ds,ax

mov dx, offset var1
mov ah,9
int 21h

mov dl,10
mov ah,2
int 21h

mov dl,13
mov ah,2
int 21h

lea dx, var2
mov ah,9
int 21h

mov ah,4ch
int 21h



main endp
end main