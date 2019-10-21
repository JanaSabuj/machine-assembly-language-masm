dosseg
.model small
.stack
.data
primenum db 50 dup(?)
.code
main proc
    mov ax,@data
    mov ds,ax
    mov dl,1
    mov cx,50 ; between 1 and 50

    mov si,offset primenum
    L1:mov bl,2
    add dl,1
    cmp dl,2
    je insert
    logic:mov ah,0
    mov al,dl
    div bl
    cmp ah,0
    je L1
    add bl,1
    cmp bl,al
    jb logic
    jmp insert
    insert:
	mov [si],dl
    inc si
    loop L1

	;lea si,primenum
	;mov dx,[si]
	;add dx,48
	;mov ah,2
	;int 21h

    mov ah,4ch
    int 21h
main endp

end
