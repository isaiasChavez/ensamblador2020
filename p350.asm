.model small
.386
.387
extrn reto:near
extrn des2:near
.stack
.data
num1 dd 6
num2 dd 6
.code
main:	mov ax,@data
	mov ds,ax
	mov es,ax
	finit
	fld num1
	fld num2
	fcompp		;Compara y vacía la pila.
	fstsw ax	;AX tiene palabra de estado.
	fwait
	and ah,45h	;Aplicar máscara:01000101 a parte alta.
	mov dl,ah	;Sólo interesa la parte alta.
	call des2	;Desplegar resultado y comparar con los
			; siguientes valores.
;> 00 Mayor
;< 01 Menor
;= 40 Iguales
;! 45 Valores no comparables
	.exit 0
end