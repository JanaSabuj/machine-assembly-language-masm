 
.model small
.stack 100h
.data
n dw 4
.code
main proc
mov ax, @data
mov ds, ax

; mov ax, 10
; mov dx, 0
; mov bx, 2
; div bx
; mov cx, ax
; add dx, 48
; mov ah, 2
; int 21h
; mov dx, cx
; add dx, 48
; mov ah, 2
; int 21h
; sub n, 1
; mov dx, n
; add dx, 48
; mov ah, 2
; int 21h
; mov si, 4
; mov dx, si
; add dx, 48
; mov ah, 2
; int 21h
sub n, 1
cmp n, 3
je l1
mov ah, 4ch
int 21h

l1:
mov dx, 49
mov ah, 2
int 21h
mov ah, 4ch
int 21h

main endp
end main
