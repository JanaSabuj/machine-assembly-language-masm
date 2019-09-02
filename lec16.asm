dosseg
.model small
.stack 100h
.data
.code
main proc

mov cx,26
mov dl,65

l1:
mov ah,2
int 21h

add dl,1
loop l1

mov ah,4ch
int 21h

main endp
end main