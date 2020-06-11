
; POR TERMINAR
.model small
.386
extrn reto:near
extrn des2:near
extrn lee2:near
extrn lee4:near
.stack

.data
print	macro cadena
local dbcad,dbfin,salta
	pusha			;respalda todo
	push ds			;respalda DS, porque vamos a usar segmento de código
	mov dx,cs		;segmento de código será también de datos
	mov ds,dx
	
	mov dx,offset dbcad	;dirección de cadena (en segmento de código)
	mov ah,09h
	int 21h			;desplegar
	jmp salta		;saltar datos para que no sean ejecutados
 dbcad	db cadena		;aquí estará la cadena pasada en la sustitución
 dbfin	db 24h			;fin de cadena
salta:	pop ds			;etiqueta local de salto, recuperar segmento de datos
	popa			;recuperar registros
endm
arr1	db "minino"
arr2	db "aaaaminiaaaa"






.code
main:	
    mov ax,@data
	mov ds,ax
	mov es,ax ;Sean ambos el mismo segmento.
	cld
	mov si,offset arr1
	mov di,offset arr2
salto:
	mov cx,6
	mov bx,di
	repe cmpsb	;Se detendrá en dos posibles casos:
			; -encontró una diferencia
			; -CX llegó a 0.
	jne difer	;Son diferentes si está apagada
			; la bandera del cero.
	;Aquí la acción a realizar por ser iguales
    print "Se encontró la cadena"
	jmp salida
	
 difer:	;Aquí la acción a realizar por ser diferentes
    print "son diferentes"
	cmp cx,0h
	je salida

	inc bx
	mov di,bx
	mov si,offset arr1
	jmp salto 

 salida:
    .exit 0
end