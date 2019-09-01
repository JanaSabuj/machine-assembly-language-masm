.model small
.stack 100h

printStr macro strval	;for printing a string
    lea dx, strval
    mov ah, 09h
    int 21h
endm

accVal macro val       ;accepting a character
    mov ah, 1h 
    int 21h
    sub al, 48
    mov val, al
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

Divd macro num1, num2, R
	mov ax, num1
	mov dx, 0000h
	mov cx, num2
	div cx
	mov R, ax
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
stropt db "1. Add",lf,cr,"2. Subtract",lf,cr,"3. Multiply",lf,cr,"4. Divide(Integer)",lf,cr,"5. Modulo",lf,cr,"Enter choice: $" 
str1 db "Enter number: $"
str2 db " ",lf,cr,"The result is: $"
op db ?
fl db ?
no1 dw ?
no2 dw ?
res dw ?
.code 
main proc
begin:
    mov ax, @data
    mov ds, ax
    printStr stropt     
    accVal op
	
	printStr str1
    accNum no1, fl
	
	printStr str1
	accNum no2, fl
    
	;printNum no1
	;printNum no2
	
	cmp op, 1
    jne opt2  
	Addn no1, no2, res  
    jmp prnt
	
	opt2:
	cmp op, 2
	jne opt3
	Subs no1, no2, res
    jmp prnt
	
	opt3:
    cmp op, 3
	jne opt4
	Mult no1, no2, res
    jmp prnt
	;jmp Add
    
    opt4: 	
    cmp op, 4
    jne opt5 
	Divd no1, no2, res
	jmp prnt
    
	opt5:
    cmp op, 5
	jne  exit
	Modl no1, no2, res 
	
	prnt:
	printStr str2
	printNum res
exit:                                       
    mov ah, 4ch
    int 21h  
main endp

end main