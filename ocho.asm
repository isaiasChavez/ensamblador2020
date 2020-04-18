.MODEL SMALL
.STACK
.DATA
.CODE
main: 
   
    
    call lee4
    mov dx,ax
    call lee4
    add ax,dx
    mov dx,ax
    call des4
   .exit
lee1: 
    mov ah,01h
    int 21h
    sub al,30h
    cmp al,9h
    jle l1s
    sub al,7h ;Me deja el resultado en al
l1s:ret


lee2:
    push bx
    call lee1
    mov cl,4
    shl al,cl ;nuevo código
    mov bl,al
    call lee1
    add bl,al
    mov al,bl
    pop bx
                ;Deja el resultado en al
    ret

lee4:
    call lee2
    mov bl,al
    call lee2
    mov ah,bl
    ret 

des1:
    add dl,30h  ;Recibe por dl
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


des2:   ;Recibe por dl
    mov bl,dl; Se le pasó el dato como parámetro por medio de dl
    mov cl,4
    shr dl,cl
    call des1
    mov dl,bl
    and dl,0Fh
    call des1
    ret

des4:
    push dx
    mov dl,dh
    call des2
    pop dx
    call des2
    ret

end
