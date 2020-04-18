.model small
public lee1
public lee2
public lee4
public des1
public des2
public des4
public reto
public desm

public des2n

.stack
.code
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
    push cx
    

    call lee1
    mov cl,4
    shl al,cl ;nuevo código
    mov bl,al
    call lee1
    add bl,al
    mov al,bl

    
    pop cx
    pop bx
                ;Deja el resultado en al
    ret

lee4:; Deja el resultado en ax
    push bx
    call lee2
    mov bl,al
    call lee2
    mov ah,bl
    pop bx
    ret 

desm:
    push ax
    mov ah,09
    int 21h
    pop ax
    ret
des1: ;Lo comentado es para desplegar en digito
    push ax
    add dl,30h  ;Recibe por dl
    cmp dl,39h
    jg sumar
    mov ah,02
    int 21h
    pop ax
    ret
sumar: 
     add dl,07h
     mov ah,02
     int 21h
     pop ax
     ret


des2:   
    push cx
    push bx
    
    ;Recibe por dl
    mov bl,dl; Se le pasó el dato como parámetro por medio de dl
    mov cl,4
    shr dl,cl
    call des1
    mov dl,bl
    and dl,0Fh
    call des1
    pop bx
    pop cx
    ret
des1n: ;Lo comentado es para desplegar en digito
    push ax
    add dl,30h  ;Recibe por dl
    cmp dl,39h
    jg sumar
    mov ah,02
    int 21h
    pop ax
    ret
sumarn: 
     add dl,07h
     mov ah,02
     int 21h
     pop ax
     ret


des2n:   
    push bx
    push ax

    mov bl,dl
    and dl,80h
    jz noneg 
    not bl
    inc bl
    mov dl,2Dh
    mov ah,02h
    int 21h
noneg:
    mov dl,bl
    call des2

    pop ax
    pop bx
	ret

des4:
    push dx
    mov dl,dh
    call des2
    pop dx
    call des2

    ret
reto:
    push dx
    push ax

    mov dl,0Dh
    mov ah,02h
    int 21h
    mov dl,0Ah
    mov ah,02h
    int 21h
    pop ax
    pop dx
    ret


    
end