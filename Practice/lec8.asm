dosseg
.model small
.stack 100h
.data
.code
main proc

mov ah,1
int 21h

mov dl,10
mov ah,2
int 21h


mov dl,13
mov ah,2
int 21h

mov dl,al

mov ah,2
int 21h

mov ah,4ch
int 21h




main endp
end main
