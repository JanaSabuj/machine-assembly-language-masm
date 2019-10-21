.model small
.stack 100h
.data
num db 10 dup('$')
msgNeg db 'Given Number is Negative. $'
msgPos db 'Given Number is Positive. $'
.code
main proc

mov ax,@data
mov ds,ax

mov si, offset num
inputString:
mov ah, 1
int 21h
cmp al, 13
JE CheckNum
mov [si],al
inc si
jmp inputString
CheckNum:


cmp num,'-'
JE PrintNeg
mov dx, offset msgPos
mov ah, 9
int 21h
mov ah,4ch
int 21h

PrintNeg:
mov dx, offset msgNeg
mov ah, 9
int 21h

mov ah,4ch
int 21h
main endp
end main