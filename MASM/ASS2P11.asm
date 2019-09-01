 .model small 
        .stack 64 
        .data 
bytes dd 0040004ch 
rows db ? 
cols db ? 
msg1 db 0dh,0ah,'Total no of rows(in hex)=','$' 
msg2 db 0dh,0ah,'Total no of columns(in hex)=','$' 
msg3 db 0dh,0ah,'Press any key to clear screen','$' 
hexcode db '0123456789abcdef' 
        .code 
display proc 
        push ax 
        push bx 
        push cx 
        push dx 
        lea dx,msg1       ;displays msg1 
        mov ah,09h 
        int 21h 
        mov al,rows     ;al=no of rows[25] 
        mov cl,10h 
        mov ah,00h 
        div cl          ;25/10 | al=quotient[2] | ah=remainder[5] 
        mov bl,al       ;al=2 
        mov dl,hexcode[bx] ;dl=8 bit ascii code of char to be displayed[2] 
        push ax 
        mov ah,02h      ;display char to std o/p dev 
        int 21h 
        pop ax 
        mov bl,ah       ;ah=5 
        mov dl,hexcode[bx] ;dl=8 bit ascii code of char to be displayed[5] 
        mov ah,02h      ;display char to std o/p dev 
        int 21h 
        lea dx,msg2     ;displays msg2 
        mov ah,09h 
        int 21h 
        mov al,cols     ;al=no of cols[80] 
        mov cl,10h 
        mov ah,00h 
        mov bh,00h 
        div cl          ;80/10 | al=quotient[8] | ah=remainder[0] 
        mov bl,al       ;al=8 
        mov dl,hexcode[bx]  ;dl=8 bit ascii code of char to be displayed[8] 
        push ax 
        mov ah,02h      ;display char to std o/p dev 
        int 21h 
        pop ax 
        mov bl,ah       ;ah=0 
        mov dl,hexcode[bx]  ;dl=8 bit ascii code of char to be displayed[0] 
        mov ah,02h      ;display char to std o/p dev 
        int 21h 
        pop dx 
        pop cx 
        pop bx 
        pop ax 
        ret 
display endp            ;end display procedure 
  
main: 
        mov ax,@data 
        mov ds,ax 
        mov ah,0fh 
        int 10h 
        mov cols,ah     ;ah=no of char cols on screen 
        mov cl,ah 
        mov ch,0 
        push ds 
        lds si,bytes 
        mov ax,[si]     ;ax=total no of bytes on video page(1b ascii+1b AB) 
        pop ds 
        shr ax,1        ;divides ax by 2 to get total no of chars on page 
        div cl 
        mov rows,al 
        call display 
        lea dx,msg3 
        mov ah,09h ;displays msg3 
        int 21h 
        mov ah,01h ;i/p char from std i/p dev & echo to std o/p dev 
        int 21h 
        mov dh,0 ;initialize row coordinate to 0 
again: 
        mov bh,0 ;bh=page 0 
        mov dl,0 ;initialize column coordinate to 0 
        mov ah,02h ;set cursor position to (dl,dh) 
        int 10h 
        mov bl,0 ;colour(set foregnd & bckgnd of char with same colour) 
        mov al,'x' ;char to be displayed 
        mov ah,09h ;write char at cursor position 
        int 10h 
        inc dh  ;inc row coordinate by one position 
        cmp dh,rows 
        jb again 
        mov ah,4ch ;exit 
        int 21h 
end main
