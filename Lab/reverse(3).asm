.MODEL SMALL  
.STACK 100H  
.DATA     
STRING DB 'This is a sample Sabuj', '$'
  
.CODE  
MAIN PROC FAR  
MOV AX,@DATA  
MOV DS,AX      
CALL REVERSE    
LEA DX,STRING  
    
MOV AH, 09H  
INT 21H  
   
MOV AH, 4CH 
INT 21H  
  
MAIN ENDP  
REVERSE PROC    
    MOV SI, OFFSET STRING    
    MOV CX, 0H    
    LOOP1: 
    
    MOV AX, [SI]  
    CMP AL, '$'
    JE LABEL1  
    
    PUSH [SI]  
      
    INC SI  
    INC CX    
    JMP LOOP1    
    LABEL1: 
   
    MOV SI, OFFSET STRING    
        LOOP2:          
        CMP CX,0  
        JE EXIT     
        POP DX         
        XOR DH, DH  
     
        MOV [SI], DX     
        INC SI  
        DEC CX    
        JMP LOOP2  
                    
    EXIT:    
    MOV [SI],'$ '
    RET  
          
REVERSE ENDP  
END MAIN