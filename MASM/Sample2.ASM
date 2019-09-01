.MODEL SMALL
.STACK 100H
.DATA
        X       DW      10      DUP(?)
        LF      EQU     0AH
        CR      EQU     0DH
        MSG     DB      LF,CR,'$'
.CODE
MAIN PROC
                MOV     AX,@DATA
                MOV     DS,AX
                LEA     SI,X
                MOV     AX,00H
                MOV     [SI],AX
                ADD     SI,02
                MOV     AX,01H
                MOV     [SI],AX
;
                MOV     CX,08H
        L1:     ADD     SI,02
                XOR     DX,DX
                ADD     DX,[SI-04]
                ADD     DX,[SI-02]
                MOV     AX,DX
                AND     AX,000FH
                CMP     AX,09H
                JG      L2
                JMP     L3
        L2:     ADD     DX,06H
        L3:     MOV     [SI],DX
                LOOP    L1
;
                MOV     CX,0AH
                LEA     SI,X
        L4:     PUSH    CX
                MOV     CX,02H
                XOR     BX,BX
                MOV     BL,[SI]
        L5:     PUSH    CX
                MOV     CL,04H
                ROL     BL,CL
                MOV     DX,BX
                AND     DX,000FH
                ADD     DX,30H
                MOV     AH,02H
                INT     21H
                POP     CX
                LOOP    L5
                LEA     DX,MSG
                MOV     AH,09H
                INT     21H
                ADD     SI,02
                POP     CX
                LOOP    L4

                MOV     AH,4CH
                INT     21H
MAIN ENDP
END MAIN
