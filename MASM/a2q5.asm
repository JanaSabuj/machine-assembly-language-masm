.model small
.stack 100h
.data
    msg1 db 10,13,'Enter first number : $'
    msg2 db 10,13,'Enter second number : $'
    msg3 db 10,13,'Enter third number : $'
    msg4 db 10,13,'GCD of the three numbers : $'
    n1 dw ?
    n2 dw ?
    n3 dw ?
    gcd dw ?
.code
main proc
mov ax,@data
mov ds,ax

lea dx,msg1
mov ah,09h
int 21h
call get_input
mov n1,bx

lea dx,msg2
mov ah,09h
int 21h
call get_input
mov n2,bx

lea dx,msg3
mov ah,09h
int 21h
call get_input
mov n3,bx

mov ax,n1
mov bx,n2
call gcd_proc
mov gcd,bx

mov ax,gcd
mov bx,n3
call gcd_proc
mov gcd,bx

lea dx,msg4
mov ah,09h
int 21h

mov ax,gcd
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
je display

display:
pop dx
mov ah,02h
int 21h
loop display

mov ah,04ch
int 21h
main endp

get_input proc
xor bx,bx
xor cx,cx
input:
mov ah,01h
int 21h
cmp al,0dh
je exit_input
and ax,000fh
mov cx,ax
mov ax,10
mul bx
mov bx,ax
add bx,cx
jmp input
exit_input:
ret
get_input endp

gcd_proc proc
up:
cmp ax,bx
je exit
jb excg
up1:
mov dx,0h
div bx
cmp dx,0
je exit
mov ax,dx
jmp up
excg:
xchg ax,bx
jmp up1
exit:
ret
gcd_proc endp

end main