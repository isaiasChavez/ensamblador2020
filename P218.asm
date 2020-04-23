;Modifique la función del programa mostrado de manera que la función,
;al entrar, guarde en la variable local el valor del primer parámetro,
;en calidad de "mayor". Y vaya comparando con cada una de las siguientes. 
;Y si la siguiente es mayor, su valor será escrito en la variable como nuevo campeon. 
;Y así hasta terminar. Devolverá el valor del campeón, es decir, el mayor.

.model small
extrn reto:near
extrn lee4:near
extrn des2:near

.stack
.data
dato db 'abcdefghijklmnaaaaaaaaaaaaaaaaaaaaa','$'


.code
main:	
    mov ax,@data
	mov ds,ax
	
	lea bx,dato

	call lee4
	push ax	
	call reto
	call lee4
	push ax
	call reto

	CALL memo
	ADD SP,08	;4 push * 2 = 8
		
	mov dl,al
	call des2
	.exit
	
memo:			;ENTRADA A LA FUNCIÓN
                ;Primer parametro direccion de memoria del inicio de la porcion 16 bits
                ;Numero de bites a desplegar

	push bp
	mov bp,sp	;pila: |bp ret| dato4 dato3 dato2 dato1 /Mueve bp a la dirección de la base de la pila
                ;bp/sp-^
	sub sp,02	;Al bajar el SP, se está reservando espacio de 2 bytes
			; y se pueden usar con BP haciendo [BP-2]. |NO USAR SP|.
			;pila: var |bp ret| dato4 dato3 dato2 dato1 /bp y ret se agregan cuando entramos a la función 
			;bp--------^
			;sp----^
		
	mov ax,[bp+6]	;Se llama al primer parámetro
                ;pila: var |bp ret| dato4 dato3 dato2 dato1  
			;bp-----------^
			;sp-------^
	mov [bp-2],al	;Se carga en la variable local el primer dato/no se compara por se el primero
    mov ax,[bp+4]	;Se llama al Segundo parámetro
                    ;Ahora tenemos los dos datos en [bp-2] y al 


    mov cx,ax
    mov bx,[bp-2]
ciclo:

    mov dl,[bx]
    call des2
	call reto
	inc bx
    loop ciclo
    
	MOV al,[bp-2]	;Resultado de la variable a AL
	mov sp,bp	;Se libera espacio de variable local / Mueve a SP la dirección donde se aloja bp ya que no necesito más esa memoria

			; en lugar de ADD SP,02
	pop bp	;Regresa bp a la dirección donde fuera que estaba, bp es un apuntador auxiliar
	ret	
end