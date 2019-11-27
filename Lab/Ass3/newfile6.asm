.model small
.stack 100h
.data
file DB '~/Downloads/MP/newfile.asm',0      ; File Path (Note: Folders are not created, so always create a file inside existing folderor drive). 0 is used to append the file
msg DB 'File created','$'  ; To display successful message when File is created
.code
main proc 
mov ax,@data
mov ds,ax
 
mov al,00h                ; For file creation, AX=3C00H and CX=0000H
mov ah,3ch
lea dx,file                ; Load the file path to DX
mov cx,0000h               ; Create the File, AX=3C00H
int 21h
 
jc exit                    ; If carry Flag is Set, It means File is not Created
lea dx,msg                 ; Load the Success Message
mov ah,09h
int 21h
 
exit:
mov ah, 4ch
int 21h
main endp
end main
