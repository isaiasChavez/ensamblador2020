.MODEL SMALL
.STACK
.DATA

.CODE
main: 
      
    call lee1
	mov bl,al	;Dato 1 en BL
	call lee1	;Dato 2 en AL
    
	add al,bl	;Resultado en AL
	mov dl,al	;Resultado en DL
	call des1
   
   .exit
lee1: 
    
    mov ah,01h
    int 21h
    sub al,30h
    cmp al,9h
    jle l1s
    sub al,7h ;Me deja el resultado en al
l1s:ret




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

end
