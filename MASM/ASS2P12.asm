 .model small 
        .stack 64 
        .data 
str db 'ABCDEFGH' 
oldrow db 15 
oldcol db 25 
newrow db 18 
newcol db 35 
        .code 
main: 
        mov ax,@data 
        mov ds,ax 
        mov bh,0     ;bh=page 0 
        mov si,0 
        mov dh,oldrow 
        mov dl,oldcol 
repeat: 
        mov ah,02h   ;set cursor position at (dh,dl) 
        int 10h 
        mov al,str[si] 
        mov bl,07h 
        mov cx,1 
        mov ah,09h 
        int 10h 
        inc dl 
        inc si 
        cmp si,08 
        jl repeat 
        mov si,08 
again: 
        call movchar 
        inc oldcol 
        inc newcol 
        dec si 
        jnz again 
        mov ah,4ch 
        int 21h

movchar proc 
        mov dh,oldrow 
        mov dl,oldcol 
        mov ah,02h 
        int 10h 
        mov ah,08h      ;to read a char and its attribute 
        int 10h 
        mov bl,ah       ;bl=attribute byte(07h) 
        mov dh,newrow 
        mov dl,newcol 
        mov ah,02h      ;set cursor position at (dh,dl) 
        int 10h 
        mov ah,09h 
        mov cx,1 
        int 10h 
        ret 
movchar endp 
end main
