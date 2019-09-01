dosseg
.model small
.stack 100h
.data
.code
.main proc

mov bl,3
mov cl,5
ADD bl,cl
ADD bl,48

mov dl,bl

mov ah,2
int 21h

mov ah,4ch
int 21h



.main endp
end
