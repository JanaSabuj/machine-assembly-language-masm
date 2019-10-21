dosseg
.model small
.stack 100h
.data
.code
main proc

mov cx,1 ;odd number
mov ax,0 ;sum initialised

l1:
add ax,cx
add cl,2 ;i += 2
cmp cl,100 ;i < 100
jl l1

; now ax stores the sum
; now we will extract the digits and push them to a stack

mov dx,0 ;DX:AX will be the dividend
mov bx,10 ; divisor
mov cx,0 ;count of digits pushed in stack

l2:
div bx
push dx ;dx is the remainder or the modulo

mov dx,0
mov ah,0
inc cx ;update count
cmp ax,0 ;while n!=0
jne l2

; time to print the digits 
; cx has the count for the loop
l3:
pop dx
add dx,48
mov ah,2
int 21h
loop l3

mov ah,4ch
int 21h

main endp
end main