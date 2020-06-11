.model small
;FINAL
extrn reto:near
extrn lee2:near
extrn des4:near
extrn des2:near
.stack
.data
a1 db 0
a2 db 0
b1 db 0
b2 db 0
c1 db 0
c2 db 0
.code
main:	
    mov ax,@data
	mov ds,ax

    call lee2
	mov a1,al	;primero, alta
	call lee2
	mov b1,al	;primero baja
    call lee2
	mov c1,al                ;bx ya está ocupado

    call reto

 	call lee2
	mov a2,al	;primero, alta
	call lee2
	mov b2,al	;primero baja
    call lee2
	mov c2,al                ;bx ya está ocupado
    call reto   ;imprime salto de linea
;////////////////////////////
    mov al,c2
    mov ah,b2
    mov bl,a2
    add c1,al
    adc b1,ah
    adc a1,bl

    call reto
	jnc sigue
	push ax
	mov ah,02h
	mov dl,'1'
	int 21h
	pop ax
sigue:
    mov dl,a1
    call des2
    mov dl,b1
    call des2
    mov dl,c1
    call des2
        
	.exit
end