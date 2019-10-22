.model small 
.stack 100h
.data
n dw 20
.code
main proc
mov ax, @data
mov ds, ax

mov dx, 50      ; Printing 2 upfront
mov ah, 2
int 21h
mov cx, 2

l1: 

inc cx
mov ax, cx
mov bx, 2

l2:
mov dx, 0
div bx
cmp dx, 0
je l3
inc bx
mov ax, cx
cmp bx, cx

jl l2

mov dx, '$'
push dx
mov ax, cx

pushing:

mov dx, 0
mov bx, 10
div bx
push dx
cmp ax, 0

jg pushing

poping:

pop dx
cmp dx, '$'
je l3
add dx, 48
mov ah, 2
int 21h

jmp poping

l3:
sub n, 1
cmp n, 0

jg l1

mov ah, 4ch
int 21h

main endp
end main 
