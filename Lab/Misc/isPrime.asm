.MODEL SMALL
.DATA
MSG DB "The Give No is a Prime No$"
NMSG DB "The Given No is not a Prime No$"
NUM DB 18     ;Enter the required no here
.CODE

START: MOV AX,@DATA
MOV DS,AX

MOV AL,NUM
MOV BL,02H      ; The Dividing starts from 2, Hence BH is compare to 02H
MOV DX,0000H    ; To avoid Divide overflow error
MOV AH,00H      ; To avoid Divide overflow error

;Loop to check for Prime No
L1:DIV BL
CMP AH,00H      ; Remainder is compared with 00H (AH)
JNE NEXT
INC BH          ; BH is incremented if the Number is divisible by current value of BL
NEXT:CMP BH,02H ; If BH > 02H, There is no need to proceed, It is not a Prime
JE FALSE        ; The no is not a Prime No
INC BL          ; Increment BL
MOV AX,0000H    ; To avoid Divide overflow error
MOV DX,0000H    ; To avoid Divide overflow error
MOV AL,NUM      ; Move the Default no to AL
CMP BL,NUM      ; Run the loop until BL matches Number. I.e, Run loop x no of times, where x is the Number given
JNE L1          ; Jump to check again with incremented value of BL

;To display The given no is a Prime No
TRUE: LEA DX,MSG
MOV AH,09H      ; Used to print a string
INT 21H
JMP EXIT

;To display The given no is not a Prime No
FALSE: LEA DX,NMSG
MOV AH,09H      ; Used to print a string
INT 21H


EXIT:
MOV AH,4CH
INT 21H
END START
