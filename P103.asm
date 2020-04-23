.MODEL SMALL
.STACK
.DATA

dato db ?
msg db 'Ingrese un digito','$'
.CODE
main: mov ax,@data
      mov ds,ax
    mov ah,09h
    lea dx,msg
    int 21h
    mov ah,01
    int 21h
    
    cmp al,57
    je sumar

    inc al

    mov dl,al
    mov ah,02h
    int 21h
    .exit
sumar:
    add al,08h
    mov dl,al
    mov ah,02h
    int 21h
    .exit

.exit



end