.model small
extrn reto:near
extrn lee2:near

extrn desm:near ;Desplegar mensaje
extrn des2:near

.stack
.data
arreglo db 3 dup(?)
arreglo2 db 3 dup(?)


aux db 0,'$'
resu db 10,13,'El resultado es: ',10,13,'$' 
salto db 10,13,'$'


.code

 
    main proc
    mov ax,@data
    mov ds,ax

    mov bx,offset arreglo
    mov cx,3
    ciclo:
        call lee2
        mov [bx],al
        inc bx ;Apuntará al siguiente dato
    loop ciclo

     mov bx,offset arreglo2
     mov cx,3h
    ciclo2:
        call lee2
        mov [bx],al
        inc bx ;Apuntará al siguiente dato
    loop ciclo2

    mov bx,offset arreglo
    mov ax,offset arreglo2

    mov cx,3h
    ciclo3:
        mov aux,word ptr[ax]

        adc [bx],aux
        inc bx
        inc ax
    loop ciclo3
    mov bx,offset arreglo
    mov cx,3h
    ciclo4:
        mov dl,[bx]
        call des2
        inc bx
    loop ciclo3
    
    

    .exit
    main ENDP
end
