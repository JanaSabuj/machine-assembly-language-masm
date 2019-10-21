.model small
.stack 100h
.data
	STRING1 DB 1,2,7,5
	res db ?
.code
main proc

mov ax,@data
mov ds,ax

mov cx, 4
mov bl, 0
LEA SI, STRING1

up:
mov al, [SI]
cmp al, bl
jl nxt
mov bl, al

nxt:
inc si
dec cx
jnz up

mov res,bl
mov dl,res
add dl,48
mov ah,2
int 21h

mov ah,4ch
int 21h

main endp
end main
