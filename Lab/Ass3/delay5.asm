.model small
.stack 100h
.data
	msg1 db 'Before delay$'
	msg2 db 'After delay$'
.code
  main proc
	mov ax,@data
	mov ds,ax
	
	lea dx,msg1
	mov ah,9
	int 21h
	
	mov dx,164
	mov cx,65535
  l1:
	dec dx
	MOV CX,65535
    l2:
	   dec cx
	   nop
	   jnz l2
	cmp dx,0
	jne l1
	
	
	lea dx,msg2
	mov ah,9
	int 21h
	
	mov ah,4ch
	int 21h
	
	main endp
	end main
