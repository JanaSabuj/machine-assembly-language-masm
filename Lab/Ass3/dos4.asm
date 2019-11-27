.MODEL small
.STACK 100h
.DATA
	LEN 	db "LENGTH: $"
	PAR 	db "PARAMS: $"
	param 	db 30 dup(?)
	NL		db 10, 13, '$'
.CODE
MAIN PROC
	MOV bx, 80h					; length of CMD stored at PSP
	MOV cl, [bx]				; moving it to cl
	
	MOV ax, @data
	MOV ds, ax

	LEA dx, LEN					; printing length msg
	MOV ah, 09h
	INT 21h

	MOV ax, 0
	MOV al, cl
	MOV ch, 10
	MOV dx, '$'
	PUSH dx
	JMP PRINT_PUSH				; printing length

	PARAMETERS:
		LEA dx, NL				; printing new line
		MOV ah, 09h
		INT 21h

		LEA dx, PAR				; printing parameters msg
		MOV ah, 09h
		INT 21h

		MOV ah, 62h				; loading Program Segment Prefix on bx
		INT 21h

		MOV ds, bx				; setting ds as PSP
		MOV dx, 81h				; cmdline params starting from 81h, including space
		MOV bx, dx
		ADD bl, cl
		MOV BYTE PTR[bx], '$'	; putting '$' at the end of the cmdline param in the memory
		MOV ah, 09h				; printing from 81h to where the '$' is present, i.e., end of cmdline params
		INT 21h
		JMP EXIT				; EXIT

	PRINT_PUSH:
		CMP al, 0
		JE PRINT_POP
		MOV dx, 0
		MOV ah, 0
		DIV ch
		MOV dl, ah
		PUSH dx
		JMP PRINT_PUSH

	PRINT_POP:
		POP dx
		CMP dl, '$'
		JE PARAMETERS
		ADD dl, 48
		MOV ah, 02h
		INT 21h
		JMP PRINT_POP

	EXIT:
		MOV ah, 4ch
		INT 21h
MAIN ENDP
END MAIN
