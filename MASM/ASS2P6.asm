.MODEL SMALL
.STACK 100H

.DATA
NUM1 DW 0
NUM2 DW 0
COUNT DB 0
 S1 DB 'ENTER THE VALUE OF X= ','$'
 S2 DB 'ENTER THE VALUE OF Y= ','$'
 S3 DB 13,10,'THE VALUE OF X= ','$'
 S4 DB 13,10,'THE VALUE OF Y= ','$'
 S5 DB 13,10,'THE VALUE OF SUM= ','$'

.CODE
MAIN PROC 
      MOV AX, @DATA
      MOV DS, AX

        LEA DX, S1
        MOV AH, 9
        INT 21H
        CALL INP
        MOV NUM1,BX
    LEA DX, S3
        MOV AH, 9
        INT 21H
    CALL POUT
        LEA DX, S2
        MOV AH, 9
        INT 21H
        CALL INP
        MOV NUM2,BX
    LEA DX, S4
        MOV AH, 9
        INT 21H
    CALL POUT
        CALL SUM
    LEA DX, S5
        MOV AH, 9
        INT 21H
    CALL POUT
    MOV AH,4CH
    INT 21H
    MAIN ENDP

POUT PROC    
    CMP BH,0
    JE PREDISP
    MOV COUNT,17
    JMP DISP
PREDISP:
    MOV COUNT,9
    MOV BH,BL
    MOV BL,0
         
DISP:
    CMP COUNT,0
    SUB COUNT,1
    JE LAST
    SHL BX,1
    JC NEXT
    MOV DL,48
    MOV AH,02
    INT 21H
    JMP DISP
NEXT:
    MOV DL,49
    MOV AH,02
    INT 21H
    JMP DISP
LAST:
    RET
    POUT ENDP
INP PROC
    MOV BX,0

INPUT:
       MOV AH,01H
       INT 21H
       CMP AL,13
       JE EXIT
       SHL BX,1
       SUB AL,48
       ADD BL,AL
       JMP INPUT

EXIT:
       RET 
       INP ENDP


SUM PROC
    MOV AX,NUM1
    MOV BX,NUM2
    ADD AL,BL
    DAA
    MOV DX,0
    MOV DL,AL
    MOV AL,AH
    MOV BL,BH
    ADC AL,BL
    DAA
    MOV BH,AL
    MOV BL,DL
        RET
    SUM ENDP
    
END MAIN