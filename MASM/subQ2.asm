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

printStr macro strval	
    lea dx, strval
    mov ah, 09h
    int 21h
endm

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

SubstrPos macro sent, subst, res
	local L1, L2, found, notFound
	;cl stores string pos, and ch beginning of substring
	mov cx, 0000h
	mov si, offset sent
	mov di, offset subst
	L1:
		mov al, [si]
		cmp al, '$'
		je short notFound
		
		mov al, [di]
		cmp al, [si]
		je short L2
		mov di, offset subst
		inc si
		inc ch
		mov cl, ch
		jmp short L1
	L2:
		inc di
		inc si
		inc ch
		mov al, [di]
		cmp al, '$'
		je short found
		jmp short L1
	found:
		mov ch, 0
		mov res, cx
	notFound:	
endm

.data
	lf equ 0ah
	cr equ 0dh
	ms1 db "Enter a sentence: $"
	ms2 db "Enter the string to be searched: $"
	ms3 db "String not found!",lf,cr,"$"
	ms4 db "String found at: $"
	sen db 100 dup('$')
	sst db  20 dup('$')  
	res dw -1	;res shall store either -1 or pos
.code
main proc 
	mov ax, @data
	mov ds, ax
	printStr ms1
	accStr sen
	
	printStr sen
	printStr ms2
	accStr sst
	
 	SubstrPos sen, sst, res
    cmp res, -1
	je notF
	printStr ms4
	printNum res
	jmp exit
notF:
	printStr ms3
exit:
	mov ah, 4ch
	int 21h
main endp
end main