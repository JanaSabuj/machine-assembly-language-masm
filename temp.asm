dosseg
.model small
.stack 100h
.data
.code
main proc

mov bl, '2'
mov cl, 3
add bl,cl
mov dl,bl
;sub dl,48

mov ah,2
int 21h

mov ah,4ch
int 21h

main endp
end main