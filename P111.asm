.model small
extrn reto:near
extrn lee2:near

extrn desm:near ;Desplegar mensaje
extrn des2:near

.stack
.data
arreglo db 3 dup(?)
mensaje db 'Ingrese 3 # de 2 digitos',10,13,'$' 
msg2 db 10,13,'Los datos son: ',10,13,'$' 
sum db 0,'$'
aux db 0,'$'
resu db 10,13,'El resultado es: ',10,13,'$' 
salto db 10,13,'$'

msg3 db 10,13,'Leyendo dato',10,13,'$' 
.code

 
    main proc
    mov ax,@data
    mov ds,ax

    lea dx,mensaje
    call desm

    mov bx,offset arreglo
    mov cx,3
    ciclo:
        lea dx,msg3
        call desm
        call lee2
        mov [bx],al
        
        inc bx ;Apuntará al siguiente dato
    loop ciclo

     mov bx,offset arreglo
     mov cx,3h

     lea dx,msg2
     call desm
    suma:
    
        mov al,[bx]
        add sum,al
        call des2
        inc bx ;Apuntará al siguiente dato1
    loop suma

    lea dx,salto ;SOLO IMPRIME UN SALTO DE LINEA
    call desm
    lea dx,resu ;IMPRIME TEXTO "El resultado es"
    call desm

    mov dl,sum
    call des2
    
    

    .exit
    main ENDP
end
