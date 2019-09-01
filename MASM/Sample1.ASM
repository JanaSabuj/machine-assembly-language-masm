.MODEL SMALL
.STACK 100H
.DATA
        LF      EQU     0AH
        CR      EQU     0DH
        MSG1    DB      'INSIDE MAIN PROGRAM',LF,CR,'$'
        MSG2    DB      'INSIDE PROC1',LF,CR,'$'
        MSG3    DB      'INSIDE PROC2',LF,CR,'$'
.CODE
MAIN PROC FAR
                MOV     AX,@DATA
                MOV     DS,AX
                LEA     DX,MSG1
                MOV     AH,09H
                INT     21H
                CALL    PROC1
                MOV     AH,4CH
                INT     21H
MAIN ENDP
PROC1 PROC
                LEA     DX,MSG2
                MOV     AH,09H
                INT     21H
                CALL    PROC2
                RET
PROC1 ENDP
PROC2 PROC
                LEA     DX,MSG3
                MOV     AH,09H
                INT     21H
                RET
PROC2 ENDP
END MAIN
