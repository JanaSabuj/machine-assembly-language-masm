.model small
.stack 100h

printStr macro strval	
    lea dx, strval
    mov ah, 09h
    int 21h
endm

FillStr macro str1, chr		;fill the string with reqired character
    local L1, L2
    mov bx, offset str1
    mov cl, chr
    L1:
	mov al, [bx]
	cmp al, '$'
	je short L2
	mov [bx], cl
	inc bx
	jmp short L1
    L2:
endm

acceptStr macro st
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
	Endaccept:		;ending with space
		mov al, ' '
		mov [si], al
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
	ms1 db "Enter sentence1: $"
	ms2 db "Enter sentence2: $"
	ms3 db "Common words: $"
	ms4 db "String found at: $"
	ms5 db ", $"
	sen1 db 100 dup('$')
	sen2 db 100 dup('$')
	wrd db 20 dup('$')
	res dw -1	;res shall store either -1 or pos
	chr1 db '$'
	adr dw ?
.code
main proc 
	mov ax, @data
	mov ds, ax
	printStr ms1
	acceptStr sen1
	;extract from sentence2
	printStr ms2
	acceptStr sen2
	printStr ms3
	mov si, offset sen2
	mov adr, si
	Lst:
		mov si, adr
		mov al, [si]
		cmp al, '$'
		je exit
		
		FillStr wrd, chr1
		mov bx, offset wrd
		
		L2nd:
			mov al, [si]
			cmp al, ' '
			je compute
			mov [bx], al
			inc si
			inc bx
			jmp L2nd
		compute:
			mov [bx], al
			inc si
			mov adr, si
			SubstrPos sen1, wrd, res
			cmp res, -1
			je Lst
			printStr wrd
			printStr ms5
			mov res, -1
			jmp Lst
exit:
	mov ah, 4ch
	int 21h
main endp
end main