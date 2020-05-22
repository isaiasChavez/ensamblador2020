.model small

.stack
.code
pintar	macro color,corx,cory

	
	;Desplegar algo
	mov al,color	;Amarillo.
	mov ah,0Ch	;Función escribir punto .
	mov cx,corx	;Coordenada X.
	mov dx,cory	;Coordenada Y.
	int 10h
	

endm


main:	;Leer configuración de pantalla y guardarla en la pila
	mov ah,0fh	;Función leer modo.
	int 10h
	push ax		;Guardar modo en la pila.
	;Definir pantalla 640x480, 16 colores
	mov ah,0	;Función establecer modo.
	mov al,12h
	int 10h
;----------------------------
	mov dx,0100
	mov bx,0100
	push cxv cx,20h
sas:
	mov bx,0100
	push cx
	mov cx,09h
	pinx:
		sub bx,1h
		pintar 08h bx dx
	loop pinx

	pop cx
	dec dx
loop sas
	
	
	


termina:

	;Esperar usuario (para que no termine sin poder ver)
	mov ah,00h
	int 16h
	;Restaurar pantalla
	pop ax		;Modo original en la pila.
	mov dl,al
	mov ah,0	;Función establecer modo
	int 10h		;Establecer. Queda como al principio.



 fin:	.exit 0
end