.model small
.stack 100h

setCursor macro x1, y1, pg
	mov ax, y1
	mov dl, al	;column 
	mov ax, x1
	mov dh, al	;row
	mov bh, 0
	mov ah, 02h
	int 10h
endm

readChar macro chr, pg
	mov bh, 0		;reads character at cursor position and ah=attribute  al= character
	mov ah, 08h
	int 10h
	mov chr, al
endm

WriteChar macro chr, pg
	mov al, chr
	mov bh, 0
	mov bl, pg
	mov cx, 1
	mov ah, 09h
	int 10h
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
    
.data
lf equ 0ah
cr equ 0dh
ms1 db "Enter the coidinates as asked for(1-to readfrom 2- write to): ",lf,cr,"x1= $"
ms2 db "y1= $"
ms3 db "x2= $"
ms4 db "y2= $"
x1 dw ?
y1 dw ?
x2 dw ?
y2 dw ?
fl db ?
chr db ?
count db 8
pg1 db 12
pg2 db 14
temp dw ?
s1 db "MAINAKST"
.code
main proc
	mov ax, @data
	mov ds, ax
	
	printStr ms1
	accNum x1, fl
	printStr ms2
	accNum y1, fl
	printStr ms3
	accNum x2, fl
	printStr ms4
	accNum y2, fl
	
	;mov ah, 00h
	;mov al, 13h
	;int 10h
	mov si, offset s1
	mov ax, y1
	mov temp, ax
	L2:
		cmp count, 0
		je L12
		setCursor x1, temp, pg1
		mov cl, [si]
		mov chr, cl
		WriteChar chr, pg2
		inc si
		inc temp
		dec count
	jmp L2

	L12: mov count, 8
	L1:
		cmp count, 0
		je exit		
		setCursor x1, y1, pg1
		readChar chr, pg1, s1
		
		setCursor x2, y2, pg2
		;mov dl, chr
		;mov dh, 0
		;mov ah, 02h
		;int 21h		
		WriteChar chr, pg1
		inc y1
		inc y2
		dec count
	jmp L1
	
	exit:
		mov ah, 4ch
		int 21h
main endp
end main