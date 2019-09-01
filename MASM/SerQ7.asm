.model small
.stack 100h

printStr macro strval	
    lea dx, strval
    mov ah, 09h
    int 21h
endm

accNum macro num, fl
    local accNumL1, accNumL2, X1, X2
    mov num, 0   
    mov cl, 10
	mov ch, 00
    mov bl, 0
	mov dx, 0
	mov fl, 0
    accNumL1:
       mov ax, num
       mul cx
       mov bx, ax
       mov ah, 01h 
       int 21h
       cmp al, 13
       je short accNumL2
	   cmp al, '-'
	   jne short X1
	   mov fl, 1
	   jmp short accNumL1
	   X1:
 	   sub al, 48
	   mov ah, 00h
	   add bx, ax
       mov num, bx        
       jmp short accNumL1
    accNumL2:
		cmp fl, 0
		je X2
		mov ax, num
		not ax
		add ax, 1
		mov num, ax
	X2:	
endm
    
printNum macro num
    local printNumL1, printNumL2, printNumL3, X1, X2
	mov cl, 10
	mov ch, 00
	mov ax, '$'
	push ax
	mov ax, num
	mov bx, num
	Rol bx, 1
	jnc short printNumL1		
	Not ax		;the magnitude
	add ax, 1
    printNumL1:
	    mov dx, 0
        div cx
		push dx
        cmp ax, 0
        je short printNumL2
		jmp short printNumL1
    printNumL2:
		mov bx, num
		rol bx, 1
		jnc short X1
		mov ax, '-'
		push ax
		X1:	
	    pop dx
		cmp dx, '$'
        je short printNumL3
		cmp dx, '-'
		je short X2
		add dx, 48
		X2:
		mov ah, 02h
        int 21h
        jmp short X1        
    printNumL3:
endm

Addn macro num1, num2, R
	mov ax, num1
	mov bx, num2
	add ax, bx
	mov r, ax
endm

Subs macro num1, num2, R
	mov ax, num1
	mov bx, num2
	sub ax, bx
	mov r, ax
endm

Mult macro num1, num2, R
	mov ax, num1
	mov cx, num2
	mul cx
	mov R, ax
endm

.data
	lf equ 0ah
	cr equ 0dh
	str1 db "Enter n upto which you want to calc S = 1! -2! + 3! - 4!...: $"
	str2 db "S = $"
	prod dw 1
	n dw ?
	S dw 0
	n2 dw 1
	fl db ?
.code
main proc
	mov ax, @data
	mov ds, ax
	
	printStr str1
	accNum n, fl
	add n, 1
	
	mov ax, 1
	mov dx, 0
	
	L1:
		mov ax, n2
		cmp ax, n
		je disp
		Mult prod, n2, prod
		
		mov ax, n2
		mov dx, 0
		mov cx, 0002h
		div cx
		cmp dx, 0
		je L2
			Addn S, prod, S
			add n2, 1
			jmp L1 
		L2:
			Subs S, prod, S
			add n2, 1
	jmp L1
	
	disp:
		printStr str2
		printNum S 
	exit:	
		mov ah, 4ch
		int 21h
main endp
end main