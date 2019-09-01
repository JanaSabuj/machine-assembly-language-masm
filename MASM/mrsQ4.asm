.model small
.stack 100h

Merge macro arr, ar3, i1, j1, i2, j2, temp1, temp2, k, n2
	local whileL1, whileL2, whileL3, EndMrg, L1, L2, L3
	mov si, offset arr
	mov di, offset ar3
	;equivalent to producing array of j2+j1-i2-i1+2
	mov n2, 2
	mov al, j1
	add al, j2
	sub al, i1
	sub al, i2
	add al, n2
	mov n2, al
	
	mov dl, j1
	mov dh, j2
	;temp1 = i1, temp2 = i2
	mov al, i1
	mov ah, i2
	mov temp1, al
	mov temp2, ah
	mov k, 0
	whileL1:
		cmp temp1, dl   
		jg short whileL2
		cmp temp2, dh
		jg short whileL3
		
		mov bl, temp1
		mov bh, 0
		mov cl, [si+bx]	;cl stores the ist array
		mov bl, temp2
		mov ch, [si+bx]
		
		cmp cl, ch
		JG short movL2
		
		mov bl, k
		mov bh, 0
		mov [di+bx], cl
		inc k
		inc temp1
		jmp short whileL1
	movL2:
		mov bl, k
		mov bh, 0
		mov [di+bx], ch
		inc k
		inc temp2
		jmp short whileL1
	
	whileL2:
		cmp temp2, dh
		Jg short EndMrg
		mov bl, temp2
		mov bh, 0
		mov cl,[si+bx]
		mov bl ,k
		mov bh, 0
		mov [di+bx], cl
		inc temp2
		inc k
		jmp short whileL2
	
	whileL3:
		cmp temp1, dl
		Jg short EndMrg
		mov bl, temp1
		mov bh, 0
		mov cl,[si+bx]
		mov bl ,k
		mov bh, 0
		mov [di+bx], cl
		inc temp1
		inc k
		jmp short whileL3
	
    EndMrg:
		mov k, 0
	L1:
		cmp i1, dl 
		jg short L2
		mov bl, k
		mov bh, 0
		mov cl, [di+bx]
		mov bl, i1
		mov bh, 0
		mov [si+bx], cl
		inc i1
		inc k
		jmp short L1
	L2:
		cmp i2, dh
		jg short L3
		mov bl, k
		mov bh, 0
		mov cl, [di+bx]
		mov bl, i2
		mov bh, 0
		mov [si+bx], cl
		inc i2
		inc k
		jmp short L1
	L3:
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

.data
	ms1 db ", $"
	ar1 db 91,62,23,34,41,28,75,56,12,20,71,100,66,90,5,1
	ar3 db 26 dup(0)
	n db 16
	n2 db 0
	temp1 db 0
	temp2 db 0
	k db 0
	i1 db 0
	i2 db 0
	j1 db 0
	j2 db 0
	startp db 0
	siz db 0
	num dw ?

.code
main proc
	mov ax, @data
	mov ds, ax
	
	sub n, 1
	mov siz, 1
	LoopOuter:
		mov startp, 0
		;while size<=n-1
		mov al, siz
		cmp al, n 
		jg EndOuterloop1
	 
	    LoopInner:
			;while startp<n-1
			mov ah, startp
			mov al, siz
			cmp ah, n
			jge EndInnerloop1
			;i1 = startp
			mov i1, ah
			;j1 = startp + size - 1
			mov j1, ah
			add j1, al
			sub j1, 1
			;i2 = j1 + 1
			mov bl, j1
			mov i2, bl
			add i2, 1
			;j2 = min(i2+size-1, n-1) 
			mov bh, i2
			add bh, al
			sub bh, 1
			mov j2, bh
			;if(j2<=n-1) j2 = j2 else j2 = n-1
			cmp bh, n
			jl L3
			mov cl,n
			mov j2, cl
			jmp L3
			
			;preventing jmp out of range
			EndOuterloop1:
				jmp EndOuterloop
			EndInnerloop1:
				jmp EndInnerloop
			L3:
				merge ar1, ar3, i1, j1, i2, j2, temp1, temp2, k, n2
				;startp + = 2*siz
				mov al, siz
				mov ah, 0
				mov cl, 2
				mul cl
				add al, startp
				mov startp, al
				jmp LoopInner
			EndInnerloop:
				;siz = 2*siz
				mov ah, 0
				mov al, siz
				mov cl,2
				mul cl
				mov siz, al
				jmp LoopOuter

	EndOuterloop:
		mov si, offset ar1
		add n,1
	L6:
		cmp n, 0
		je L7 
		mov al, [si]
		mov ah, 0
		mov num, ax
	    printNum num
		printStr ms1
		inc si
		dec n
		jmp L6
	L7:
	mov ah, 4ch
	int 21h
main endp
end main