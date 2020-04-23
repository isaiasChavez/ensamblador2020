.model small
extrn reto:near
extrn lee2:near
extrn des2:near
extrn reto:near
.stack
.data
.code
main:	mov ax,@data
	mov ds,ax
	call lee2	;(Esta función usa la pila, pero la restaura)
	PUSH AX		;Primer parámetro, estará en [BP+6]
			;Pila: dato1
	call lee2
	PUSH AX		;Último parámetro, estará en [BP+4]
			;Pila: dato2 dato1 (se van recorriendo)
	call lee2
	push AX

	CALL comp	;Guardará dirección de retorno en la pila
			;Al salir de la función:
			; Pila: dato2 dato1
	ADD SP,04	;Restaura la pila, quitando el efecto de los PUSH
			; Pila: <vacío> (o lo que tuviera antes)
	call reto		
	mov dl,al	;aquí está el resultado
	call des2
	.exit
	
comp:			;Pila: ret dato2 dato1
			;ENTRADA A LA FUNCIÓN
	PUSH BP		;Se respalda el apuntador de base, o base pointer.
			; No sabemos qué valor tenga pero podría ser importante
			;Pila: bp ret dato2 dato1
	MOV BP,SP	;Este valor fijo será nuestra referencia
			; para acceder a parámetros (y variables locales)
			;No usaremos por ahora variables locales.
			
			;INTERIOR DE LA FUNCIÓN
	mov ax,[bp+8]	;Carga de dato1, que está en BP+6, vean:
			; Pila: bp ret dato2 dato1
			; desde -^ hasta ------^  3 posiciones, cada una de 2 bytes.
	mov bx,[bp+6]	;Carga de dato2, que está en BP+4, vean:
			; Pila: bp ret dato2 dato1
			; desde -^ a ----^   2 posiciones, cada una de 2 bytes.
	mov cx,[bp+4]

	cmp al,bl   ;compara el segundo numero con el primero
	jb mayb  ;si el segundo es mayor
	cmp al,cl
	jb mayc
	jmp fin
mayb:
	mov al,bl
	cmp al,cl
	ja fin 
	mov al,cl
	ja fin
mayc:
	mov al,cl	
fin:
	MOV SP,BP	;Restaurar SP. Se esperaría que la función esté bien
			; balanceada. Ni siquiera se usaron variables locales
			; pero es buena práctica hacerlo así.
			;Aún cuando se hubieran usado variables locales, esta
			; operación libera el espacio utilizado.
			; Pila: bp ret dato2 dato1
	POP BP		;Restaurar BP anterior, la función que llamó a esta
			; podría requerirlo.
			; Pila: ret dato2 dato1
	ret		; Pila: dato2 dato1
end