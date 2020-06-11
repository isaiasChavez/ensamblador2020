.model small
.386
extrn	des4:near
extrn	reto:near
extrn	des2:near
.stack
.data
ndir	db 164 dup(0)
.stack
.code
main:	;Leer configuración de pantalla y guardarla en la pila
	mov ah,0fh	;Función leer modo.
	int 10h
	push ax		;Guardar modo en la pila.
	;Definir pantalla 640x480, 16 colores
	mov ah,0	;Función establecer modo.
	mov al,12h
	int 10h
	;Desplegar algo
	mov al,0Eh	;Amarillo.
	mov ah,0Ch	;Función escribir punto .
	mov cx,0200	;Coordenada X.
    salta:
	mov dx,0280	;Coordenada Y.
    salta2:
	int 10h
    inc dx
    cmp dx,300
    je salt3
    jmp salta2

salt3:
    cmp cx,400
    je fin
    inc cx
    jmp salta

fin:   
	;Esperar usuario (para que no termine sin poder ver)
	mov ah,00h
	int 16h
	;Restaurar pantalla
	pop ax		;Modo original en la pila.
	mov dl,al
	mov ah,0	;Función establecer modo
	int 10h		;Establecer. Queda como al principio.
	call des2
	call reto
 	.exit 0
end