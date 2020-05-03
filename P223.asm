.model small
.386
extrn reto:near
extrn des2:near
extrn lee2:near
extrn lee4:near
.stack
.data
arreglo db 'aaaaaaaaa','$'
.code

main:	
	mov ax,@data
	mov ds,ax
    mov es,ax

	mov ax,offset arreglo
    push ax	;DIRECCION

	call reto
	mov al,05h
	push ax ;TAMAÑO
	call reto
    
    mov al,'b'
    push ax ;VALOR
	call reto

	CALL P223

	ADD SP,08	;4 push * 2 = 8
		
	mov cx,07h
    mov ax,offset arreglo
    mov si,ax
    
    CLD ;AQUÍ SE MODIFICA EL SENTIDO DEL RECORRIDO 
ciclo:
    lodsb;Carga en AL dato apuntado por SI e; incrementa SI
    mov dl,al
    call des2;Despliega dato
    loop ciclo

	.exit

P223:
    push bp
	mov bp,sp	;pila: |bp ret| dato4 dato3 dato2 dato1 /Mueve bp a la dirección de la base de la pila
                ;bp/sp-^
	
		
	mov ax,[bp+8]	;Se llama al primer parámetro
                ;pila: var |bp ret| dato3 dato2 dato1  
			;bp-----------^
			;sp-------^
	mov di,ax	;Se carga en la variable local el primer dato/no se compara por se el primero
    
    mov ax,[bp+6]	;Se llama al Segundo parámetro
                    ;Ahora tenemos los dos datos en [bp-2] y al 
    mov cx,ax   ;Se coloca el tamaño del arreglo

    mov ax,[bp+4]	;Se llama al tercer parámetro
                    ;Ahora tenemos el valor a desplegar directamente en al
    

    cld
    
	rep stosb

    mov sp,bp	;Se libera espacio de variable local / Mueve a SP la dirección donde se aloja bp ya que no necesito más esa memoria

			; en lugar de ADD SP,02
	pop bp	;Regresa bp a la dirección donde fuera que estaba, bp es un apuntador auxiliar
ret
	 
end