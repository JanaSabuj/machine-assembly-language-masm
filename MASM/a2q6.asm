.model small
.stack 100h

printStr macro strval	
    lea dx, strval
    mov ah, 09h
    int 21h
endm

dispNum macro n
	local  L1, L2, L3, L4, over
	mov ah, 02h
	mov dl, n
	mov cx, 00F0h
	and dl, cl
	mov cl, 4
	shr dl, cl
	mov dh, 0
	cmp dl, 9
	jg short L2
	add dl, 48
	int 21h
	jmp short L3
	L2:
		add dl, 55
		int 21h 
	L3:	
	mov dl, n
	mov cl, 0Fh
	and dl, cl
	mov dh, 0
	cmp dl, 9
	jg short L4
	add dl, 48
	int 21h
	jmp short over
	L4:
	add dl, 55
	int 21h
over:
endm

.data
;lower address with less significant bits
num1 dw 1234,0000h
num2 dw 5678,0000h
num3 dw 3 dup(0)
n db 0
num db ?
str1 db "The sum is(in Hex): $"

.code
main proc
	mov ax, @data
	mov ds,ax
	;si+2   si+1  si
	mov si, offset num1
	mov ax, [si]
	mov di, offset num2
	mov bx, [di]
	
	add ax, bx
	jo L2
	
	add si,2
	add di,2 
	mov cx, [si]
	mov dx, [di]
	add cx, dx
	jo L3
	jmp L4
	L2:
		add si, 2
		add di, 2 
		mov cx, [si]
		add cx, 1
		mov dx, [di]
		add cx, dx
		jo L3
	L4:
		mov si, offset num3
		mov [si], ax
		mov [si+2], cx
		jmp Dsp
		
	L3:	
		mov si, offset num3
		mov [si], ax
		mov [si+2], cx
		mov cx, 1
		mov [si+4], cx
	Dsp:
		mov n, 4
		printStr str1
	Dsp2:
		cmp n, -1
		je exit
		mov bl, n
		mov bh, 00
		mov al, [si + bx]
		mov num, al
		dispNum num
		dec n
		jmp Dsp2
	exit:
		mov ah, 4ch
		int 21h
main endp
end main