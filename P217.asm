;Modifique la función del programa mostrado de manera que la función,
;al entrar, guarde en la variable local el valor del primer parámetro,
;en calidad de "mayor". Y vaya comparando con cada una de las siguientes. 
;Y si la siguiente es mayor, su valor será escrito en la variable como nuevo campeon. 
;Y así hasta terminar. Devolverá el valor del campeón, es decir, el mayor.

.model small
extrn reto:near
extrn lee2:near
extrn des2:near
extrn reto:near
extrn desm:near
.stack
.data
.code
main:	
    mov ax,@data
	mov ds,ax
	
	call lee2
	push ax	
	call lee2
	push ax
	call lee2
	push ax
	call lee2
	push ax

	CALL mayor
	ADD SP,08	;4 push * 2 = 8
	call reto
	mov dl,al
	call des2
	.exit
	
mayor:			;ENTRADA A LA FUNCIÓN
	push bp
	mov bp,sp	;pila: |bp ret| dato4 dato3 dato2 dato1 /Mueve bp a la dirección de la base de la pila
                ;bp/sp-^
	sub sp,02	;Al bajar el SP, se está reservando espacio de 2 bytes
			; y se pueden usar con BP haciendo [BP-2]. |NO USAR SP|.
			;pila: var |bp ret| dato4 dato3 dato2 dato1 /bp y ret se agregan cuando entramos a la función 
			;bp--------^
			;sp----^
		
	mov ax,[bp+10]	;primer parámetro
                ;pila: var |bp ret| dato4 dato3 dato2 dato1  
			;bp-----------^
			;sp-------^
	mov [bp-2],al	;Se carga en la variable local el primer dato/no se compara por se el primero
    mov ax,[bp+8]	;Segundo parámetro
    cmp [bp-2],al  ;Comparamos el segundo dato con el que ya tenemos en la variable local
	ja avanza       ;Si este nuevo dato es más grande lo cambiamos
    call cambio
avanza:
    mov ax,[bp+6]	;Si no, cargamos el Tercer parámetro
    cmp [bp-2],al
	ja avanza2
    call cambio
avanza2: 
    mov ax,[bp+4]	;cuarto parámetro
	cmp [bp-2],al	;Se compara con la variable local
    ja avanza3
    call cambio
avanza3:
    jmp salida

cambio:
    mov [bp-2],al
    ret
salida:
	MOV al,[bp-2]	;Resultado de la variable a AL
	mov sp,bp	;Se libera espacio de variable local / Mueve a SP la dirección donde se aloja bp ya que no necesito más esa memoria

			; en lugar de ADD SP,02
	pop bp	;Regresa bp a la dirección donde fuera que estaba, bp es un apuntador auxiliar
	ret	
end