.model small
.stack 100h

printStr macro strval	;for printing a string
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


Modl macro num1, num2, R 
	mov ax, num1
	mov dx, 0000h
	mov cx, num2
	div cx
	mov R, dx
endm


.data
	lf equ 0ah
	cr equ 0dh
	str1 db "Enter number: $"
	str2 db " ",lf,cr,"The GCD is: $"
	dis dw ?
	fl db ?
	no1 dw ?
	no2 dw ?
	no3 dw ?
	res dw ?
.code 
main proc
begin:
    mov ax, @data
    mov ds, ax
    
	printStr str1
    accNum no1, fl
	
	printStr str1
	accNum no2, fl
    
	printStr str1
	accNum no3, fl
	
	;printNum no1
	;printNum no2
	
	mov ax, no1
	cmp ax, no2
	jl L1
	mov ax, no2
	cmp ax, no3
	jl Strt
	mov ax, no3
	jmp Strt
	L1:
		cmp ax, no3
		jl Strt
		mov ax, no3
	Strt:
		mov dx, 0
		mov cx, 0002h
		div cx
		mov dis, ax
	Lp:
		cmp dis, 0
		je prnt
		Modl no1, dis, res
		cmp res, 0
		je L2n
		sub dis, 1
		jmp Lp
	    L2n:
		Modl no2, dis, res
		cmp res, 0
		je L3n
		sub dis, 1
		jmp Lp
	    L3n:
		Modl no3, dis, res
		cmp res, 0
		je prnt
		sub dis, 1
	jmp Lp
	prnt:
	printStr str2
	printNum dis
exit:                                       
    mov ah, 4ch
    int 21h  
main endp

end main