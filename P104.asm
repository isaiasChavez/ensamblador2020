.MODEL SMALL
.STACK
.DATA
.CODE
main: 
   
    call lee1
    mov bl,al
    call lee1
    add al,bl
    mov dl,al
    call des1
    mov ah,02
    int 21h

   .exit
lee1: 
    mov ah,01h
    int 21h
    sub al,30h
    cmp al,9h
    jle l1s
    sub al,7h 
l1s:ret
des1:
    add dl,30h
    cmp dl,39h
    jg sumar
    ret
sumar: 
    add dl,07h
    ret

end
