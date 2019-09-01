.model small 
        .stack 64 
        .data 
hexcode db '0123456789abcdef' 
msg db 'Total length of parameters (in Hex) is:' 
len db ?,?,0dh,0ah,'The parameters are: $' 
        .code 
hex_asc proc 
        mov dl,10h 
        mov ah,0 
        mov bx,0 
        div dl 
        mov bl,al 
        mov dh,hexcode[bx] 
        mov bl,ah 
        mov dl,hexcode[bx] 
        ret 
hex_asc endp 
main: 
        mov bx,80h 
        mov cl,[bx] 
        mov ax,@data 
        mov ds,ax 
        mov al,cl 
        call hex_asc 
        mov len,dh 
        mov len+1,dl 
        lea dx,msg 
        mov ah,09h 
        int 21h 
        mov ah,62h   ;returns with bx=segment address of PSP 
        int 21h 
        mov ds,bx 
        mov dx,81h   ;[starting from 81h in the PSP the cmd line parameters 
        mov bx,dx    ; are stored] | bx=81h or bl=81h | 
        add bl,cl    ;81h+(length of cmd line parameters) 
        mov byte ptr[bx],'$'  ;mov '$' at the end of cmd line parameters 
        mov ah,09h 
        int 21h      ;displays the cmd line parameters pointed by dx 
        mov ah,4ch   ;exit 
        int 21h 
end main 