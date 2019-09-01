.model small
.stack 100h

printStr macro strval	
    lea dx, strval
    mov ah, 09h
    int 21h
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

.data
lf equ 0ah
cr equ 0dh 
ms1 db "The length of cmd line parameters: $"
ms2 db " ",lf,cr,"The command line parameters are: $"
len dw ?
.code
main proc
	mov bx, 0080h
	mov cl, [bx]	;80h contains the number length of parameters
	
	;first store the address then go for the code
	mov ax, @data
	mov ds, ax
	mov ch, 0
	mov len, cx
	printStr ms1 

	printNum len
	
	printStr ms2
	mov dx, len
	mov ah, 62h
	int 21h		;load the beginning address of PSP to bx 

	mov ds, bx
	mov si, 81h
	mov bx, dx
	mov al, '$'		; al is stored in lower memory address
	mov ah, 0
	mov [si + bx], ax
	
	mov dx, 81h
	mov ah, 09h
	int 21h
	exit:	
		mov ah, 4ch
		int 21h	
main endp
end main