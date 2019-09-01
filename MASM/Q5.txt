.model small
.stack 100h
.data
    msg1 db 10,13,'INPUT NAME : $'
    msg2 db 10,13,'OUTPUT : $'
    str1 db ?
.code
main proc far
mov ax,@data
mov ds,ax

lea dx,msg1
mov ah,09h
int 21h

lea si,str1
loop1:
mov ah,01h
int 21h
cmp al,0dh
je loop2
mov [si],al
inc si
jmp loop1

loop2:
mov al,'$'
mov [si],al

lea dx,msg2
mov ah,09h
int 21h

lea dx,str1
mov ah,09h
int 21h

mov ah,04ch
int 21h

main endp
end main