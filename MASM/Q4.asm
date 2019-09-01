.model small
.stack 100h

.data
	num dw 0
	sum dw 0
	decimal db 50 dup('$')
	hexadecimal db 50 dup('$')
	binary db 50 dup('$')
	check db 0
	mult db 0
	inp db 'Enter a number : $'
	msg1 db 'Decimal Represntation : $'
	msg2 db 10,13,'Binary Representation: $'
	msg3 db 10,13,'Hexadecimal Representation: $'

.code
	main proc far
	mov ax,@data
	mov ds,ax

	lea si,decimal
	lea di,hexadecimal
	lea bx,binary

	lea dx,inp
	mov ah,09h
	int 21h

set:
	mov ah,01h
	int 21h
	cmp al,0dh
	je exit
	mov [si],al
	inc si
	mov ah,00h
	sub al,30h
	mov cx,ax
	mov ax,0ah
	mul sum
	mov sum,ax
	add sum,cx
	jmp set
exit:
	mov cx,04h
	mov dx,sum

hexa_val:
	call hexa_proc
	loop hexa_val

	lea dx,msg1
	mov ah,09h
	int 21h

	lea dx,decimal
	mov ah,09h
	int 21h

	lea dx,msg2
	mov ah,09h
	int 21h

	lea dx,binary
	mov ah,09h
	int 21h

	lea dx,msg3
	mov ah,09h
	int 21h

	lea dx,hexadecimal
	mov ah,09h
	int 21h

mov ah,04ch
int 21h

main endp

hexa_proc proc
	mov check,0
	mov sum,0
	call shifting
	mov mult,8
	call put
	call shifting
	mov mult,4
	call put
	call shifting
	mov mult,2
	call put
	call shifting
	mov mult,1
	call put
	cmp sum,09h
	jng last_level
	call change

last_level:
cmp check,0
jne finish
call last

finish:
ret

hexa_proc endp

last proc
add sum,30h
mov ax,sum
mov [di],al
inc di
ret
last endp

change proc
mov check,1
mov ax,sum
add ax,55
mov [di],al
inc di
ret
change endp

put proc
mov [bx],ax
inc bx
sub ax,30h
mul mult
add sum,ax
ret
put endp

shifting proc
shl dx,01h
mov ax,30h
mov num,0
adc ax,num
ret
shifting endp

end main