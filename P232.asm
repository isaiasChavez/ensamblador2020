.model small
.386
extrn	des4:near
extrn	reto:near
extrn	des2:near
.stack
.data
ndir	db 164 dup(0)
.code
main:	mov ax,@data
	mov ds,ax
	mov es,ax
	mov dl,0	;Unidad actual
	mov si,offset ndir ; ds:si buffer
	mov ah,47h	;Código para obtener ruta
	int 21h		;Obtener ruta
	jc error		;Saltar en caso de error
;desplegar directorio actual
	push offset ndir
	call despc
	add sp,02
	call reto
	.exit 0
	
	;Función para desplegar una cadena terminada en 0
	; Recibe dirección de cadena mediante la pila.
despc:	
    push bp
	mov bp,sp
	mov ah,02h	;Función para desplegar letra
	cld
	mov si,[bp+4]
 dcl:	lodsb		;Carga en AL, incrementa SI
	cmp al,0	;Si ya llegó al 0
	je dcs		;   salir
	mov dl,al
	int 21h		;Desplegar letra
	jmp dcl		;Repetir ciclo
 dcs:	mov sp,bp
 	pop bp
	ret

error:	mov dx,ax
	call des4
	.exit 1  

end