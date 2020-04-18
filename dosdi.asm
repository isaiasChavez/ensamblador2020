.model small
.stack 
.data;CAPTURAR ÚN DÍGITO
    u db 0
    d db 0
    n db 0
    msg db 10,13,7,'Ingrese un número:','$'
    msg2 db 10,13,7,'Numero ingresado: ','$'
    
.code
    main proc
        mov ax,@data
        mov ds,ax

        mov ah,09
        lea dx,msg
        int 21h

        mov ah,01h
        int 21h
        sub al,30h
        mov d,al

        mov ah,01h
        int 21h
        sub al,30h
        mov u,al

        mov al,d ;Para la multiplicación usamos los dós registros
        ;al que recibe el número que se va a multiplicar
        mov bl,10
        mul bl
        add al,u ;Cuando hacemos una multiplicación el resultado se queda
        ;en AL
        mov n,al
        
        mov ah,09h
        lea dx,msg2
        int 21h

        mov al,n
        AAM
        mov bx,ax
        mov ah,02h
        mov dl,bh
        add dl,30h
        int 21h

        mov ah,02h
        mov dl,bl
        add dl,30h
        int 21h
        
    .exit
    main ENDP
end