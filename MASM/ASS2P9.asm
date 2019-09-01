 .model small
.stack 100h
.data
 ARR DW 0022H,0023H,0024H,0032H,0044H,0047H,0048H,0050H,0060H,0070H
     LEN DW ($-ARR)/2
     KEY EQU 0044H
     MSG1 DB "KEY IS FOUND AT "
     RES DB "  POSITION",13,10," $"
     MSG2 DB 'KEY NOT FOUND!!!.$'
.code
Main proc
      MOV AX,@DATA
      MOV DS,AX
Start:
 MOV BX,00
      MOV DX,LEN
      MOV CX,KEY
AGAIN: CMP BX,DX
       JA FAIL
       MOV AX,BX
       ADD AX,DX
       SHR AX,1
       MOV SI,AX
       ADD SI,SI
       CMP CX,ARR[SI]
       JAE BIG
       DEC AX
       MOV DX,AX
       JMP AGAIN
BIG:   JE SUCCESS
       INC AX
       MOV BX,AX
       JMP AGAIN
SUCCESS: ADD AL,01
         ADD AL,'0'
         MOV RES,AL
         LEA DX,MSG1
         JMP DISP
FAIL: LEA DX,MSG2
DISP: MOV AH,09H
      INT 21H
     
      MOV AH,4CH
      INT 21H     
main endp
end main