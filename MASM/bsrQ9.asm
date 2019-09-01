.model small
.stack 100h

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

printStr macro strval	;for printing a string
    lea dx, strval
    mov ah, 09h
    int 21h
endm

.data
    ar1 dw 2,5,10,20,30,60,80,100,120,125,250,500,800
	str1 db "Present at location: $"
	str2 db "Not present$"
	val dw 60
	nel dw 13
	bad db ?
.code
main proc
	mov ax, @data
	mov ds, ax
	
	mov di, offset ar1		
	mov si, offset ar1		;si stores beginning address
	mov ax, nel
	dec ax
	Add di, ax		;di stores last address
	
	mov cx, 0002h
	mov ax, di
	mov dx, 0
	div cx
	cmp dx, 0
	je Lx
	mov bad, 1
	jmp L1
	Lx:
		mov bad, 0
	L1:
		cmp si, di
		jg L5
		
		mov ax, 0000h
		add ax, si
		add ax, di
		mov dx, 00h
		div cx
		cmp dl, bad
		je  Ly
		add ax, 1
		Ly:
		mov bx, ax
	 
		mov dx, val	 ;moves the value to be searched  
		
		cmp dx, [bx]
		je L6
		jg L3
		
		mov di, bx
		sub di, 2
		jmp L1
	
		L3:
			mov si, bx
			add si, 2
			jmp L1
	L5: 
		printStr str2
		jmp L7
	L6:
		printStr str1
		mov ax, offset ar1
		sub bx, ax
		mov ax, bx
		mov dx, 0
		div cx
		mov nel, ax
		printNum nel
	L7:
		mov ah, 4ch
		int 21h
main endp
end main