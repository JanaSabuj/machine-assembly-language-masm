.model small
.stack 100h
    
accStr macro st
	local L1, Endaccept
	mov si, offset st
	L1:
		mov ah, 01h
		int 21h
		cmp al, 13
		je short Endaccept
		mov [si], al
		inc si
	jmp short L1
	Endaccept:
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

printBCD macro num
	local psRout, popRout, L3, L4, exit	
	mov ax, num
	mov cx, 10
	mov dl, '$'
	mov dh, 0
	push dx
	psRout:
		mov dx, 0
		div cx
		push dx
		cmp ax, 0
		je short PopRout
		jmp short psRout
	popRout:
		pop bx
		cmp bx, '$'
		je short exit
		mov cl, 12
		Rol bx, cl
		mov cx, 4
		mov dx, ' '
		mov ah, 02h
		int 21h
		L3:
			cmp cx, 0
			je short popRout
			Rol bx, 1
			jc short L4
			mov dx, 48
			mov ah, 02h
			int 21h
			dec cx
			jmp short L3
		   L4: 
			mov dx, 49
			mov ah, 02h
			int 21h
		    dec cx
			jmp short L3
		
	exit:
		
endm

NumfromBCD macro num, fl
	local L1, L2, L3, L4
	mov si, offset num
	mov al, 8
	mov bx, 10
	mov fl, 0
	mov cl, 2
	L1:
		mov dl, [si]
		cmp dl, '$'
		je short L4
		
		cmp al, 0
		jne L2
		
		mov ax, fl
		mul bx
		mov fl, ax
		mov al, 8
		
		L2:	
		mov dl, [si]
		mov ah, 0
		cmp dl, 48
		je short L3
		add fl, ax
		L3:
			div cl
			inc si
		jmp short L1
	L4:		
endm

.data 
	lf equ 0ah
	cr equ 0dh
	ms1 db "Enter number to convert bcd: $"
	ms2 db " ",lf,cr,"Enter bcd(equivalent decimal) to convert to actual number: $"
	ms3 db "BCD: $"
	ms4 db " ",lf,cr,"Number : $"
	;ms5 db ", $"
	no1 dw ?
	bcd db 21 dup('$')
	fl db 0
	fl2 dw 0
	res dw 0	;res shall store either -1 or pos
	chr1 db '$'
	adr dw ?
	
.code
main proc
	mov ax, @data
	mov ds, ax
	
	printStr ms1
	accNum no1, fl
	
	printStr ms3
	printBCD no1
	
	printStr ms2
	accStr bcd 
	
	printStr ms4
	NumfromBCD bcd, fl2
	
	mov ax, fl2
	printNum fl2
	
	mov ah, 4ch
	int 21h
main endp
end main