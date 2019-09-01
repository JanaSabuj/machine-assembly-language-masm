.MODEL SMALL
.STACK 100H
.DATA
    STR1 DB 10,13,'1234 $'
    STR2 DB 10,13,'REVERSED STRING: $'
.CODE

MAIN PROC
 
    MOV AX,@DATA
    MOV DS,AX
 
    MOV AH,9
    LEA DX,STR1
    INT 21H
    
    LEA SI,STR1
    MOV CL,0
    INPUT:
	MOV AH,0
	MOV AL,[SI]
	CMP AL,'$'
 	JE END_
	PUSH AX
	INC SI
	INC CL
        JMP INPUT
    END_:
 
    MOV AH,9
    LEA DX,STR2
    INT 21H
 
    OUTPUT:
        CMP CL,0
        JE FINISH
        DEC CL
        MOV AH,2
        POP DX
        INT 21H
        JMP OUTPUT
    FINISH:
 
    MOV AH,4CH
    INT 21H
     
MAIN ENDP
END MAIN