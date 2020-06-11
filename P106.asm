.MODEL SMALL
.STACK
.DATA
.CODE
main: 
   ;EN ESE ARCHIVO ESTÁ INCLUIDO LA TAREA 6
    
    call lee2
     mov dl,bl ;Se pasa por parámetro a la función
    call des2

   
   .exit
lee1: 
    mov ah,01h
    int 21h
    sub al,30h
    cmp al,9h
    jle l1s
    sub al,7h 
l1s:ret


lee2:
    call lee1
    mov cl,4
    shl al,cl ;nuevo código
    mov bl,al
    call lee1
    add bl,al
   

    ret
des1:
    add dl,30h
    cmp dl,39h
    jg sumar
    mov ah,02
    int 21h
    ret
    sumar: 
         add dl,07h
         mov ah,02
         int 21h
         ret

des2:
    mov bl,dl; Se le pasó el dato como parámetro por medio de dl
    mov cl,4
    shr dl,cl
    call des1
    mov dl,bl
    and dl,0Fh
    call des1
    ret
    
end