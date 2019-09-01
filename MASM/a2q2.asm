.model small
.stack 100h
.data
    str db 'Assembly code$'
    substr db 'code$'
    len1 db 0
    len2 db 0
    msg1 db 10,13,'String is : $'
    msg2 db 10,13,'Substring is : $'
    msg3 db 10,13,'Substring is found at position : $'
    msg4 db 10,13,'Substring is not found$'
    pos dw -1
   
display macro msg
mov ah,09h
lea dx,msg
int 21h
endm

.code
main proc
mov ax,@data
mov ds,ax

display msg1
display str
display msg2
display substr

lea si,str
nxt1:
cmp si,0dh
je done1
inc len1
inc si
jmp nxt1
done1:

lea di,substr
nxt2:
cmp di,0dh
je done2
inc len2
inc di
jmp nxt2
done2:


lea si,str
mov al,len1
sub al,len2
mov cl,al
mov ch,0
first:
inc pos
mov al,[si]
cmp al,substr[0]
je cmpr
inc si
loop first

cmpr:

inc si
mov al,[si]
cmp al,substr[1]
jne notequal
inc si
mov al,[si]
cmp al,substr[2]
je equal

notequal:
mov pos,-1
display msg4
jmp exit

equal:
display msg3

mov ax,pos
xor cx,cx
decimal:
mov dx,0h
mov bx,0ah
div bx
or dx,30h
push dx
inc cx
cmp ax,0
jne decimal
je disp

disp:
pop dx
mov ah,02h
int 21h
loop disp

exit:
mov ah,04ch
int 21h 

main endp
end main