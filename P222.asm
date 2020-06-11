.model small
.386
extrn reto:near
extrn des2:near

.stack
.data

arreglos db 'aabcc','$'
.code

main:	
    mov ax,@data
	mov ds,ax
	mov cx,05h
    mov si,offset arreglos
    
    STD ;AQUÍ SE MODIFICA EL SENTIDO DEL RECORRIDO 
ciclo:
    lodsb;Carga en AL dato apuntado por SI e; incrementa SI
    mov dl,al
    call des2;Despliega dato
    loop ciclo
	
	.exit 0
end