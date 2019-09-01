.model small
.stack 100h
.data
	arr 	dw 	10,20,30,40,50,60,70,80,90,100,110,120
	item 	dw 	?
	prompt	db	"Enter number to be searched : $"
	success db 	"Given number found in position $"
	failure db 	"Given number not found$"
.code

main proc
	mov 	ax, @data
	mov 	ds, ax

	lea	dx, prompt
	mov	ah, 09h
	int	21h
	call	get_integer
	mov	item, bx
	lea 	bp, arr
	mov 	bx, item
	mov 	cl, 0
	mov 	ch, 11
	mov 	dl, 2
	mov 	ah, 0

   L1:	mov 	al, cl
	add 	al, ch
	div 	dl
	mov 	ah, 0
	mov 	si, bp
	add 	si, ax
	add 	si, ax
	cmp 	bx, [si]
	je 	FOUND
	jl 	L2
	add 	al, 1
	mov 	cl, al
	jmp 	L3

   L2:	sub 	al, 1
	mov 	ch,al

   L3:	cmp 	cl, ch
	jle 	L1
	lea 	dx, failure
	mov 	ah, 09h
	int 	21h
	jmp 	L4

   FOUND:
	lea 	dx, success
	mov 	ah, 09h
	int 	21h
	mov	ah, 0
	inc	ax
	call	print_integer

  L4:	mov 	ah, 4ch
	int 	21h
main endp


get_integer proc
	mov	di, 0
	mov	bx, 0
	mov	cx, 10

   get_digit:
	mov	ah, 01h
	int	21h
	cmp	al, 13
	je	check_neg
	cmp	al, 2dh
	je	set_neg
	mov	ah, 0
	sub	ax, 48
	push	ax
	mov	ax, bx
	mul	cx
	pop	dx
	add	ax, dx
	mov	bx, ax
	jmp	get_digit

   set_neg:
	mov	di, 1
	jmp	get_digit

   check_neg:
	cmp	di, 1
	jne	finish
	neg	bx

   finish:
	ret

get_integer endp


print_integer proc
	mov 	bx, 10
	mov 	cx, 0

   next_digit:
	mov 	dx, 0
	div	bx
	push	dx
	inc 	cx
	cmp	ax, 0
	jne	next_digit

   output:
	pop	dx
	add	dl, 48
	mov	ah, 02h
	int 	21h
	dec 	cx
	cmp	cx, 0
	jg	output

	ret
print_integer endp

end main