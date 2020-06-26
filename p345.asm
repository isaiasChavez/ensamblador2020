.model small
.386
.387	;Ahora es necesario también agregar el coprocesador
extrn	reto:near
extrn	des2:near
.stack
.data
RESI dd 1
AUX dd 0
RES dt 0

.code
main:	mov ax,@data
	mov ds,ax
	mov es,ax
    mov dx,offset RESI
    call desidec
    jmp fin

desidec:
	finit		;Inicializar el coprocesador.
    mov si,dx
    mov di,offset AUX
    
    cld
    mov cx,9
    rep movsb

    fild AUX
    fbstp RES
	
	fwait		;Esperar al coprocesador.
	mov bx,offset RES
    add bx,4
	mov cx,5
lop:
	mov dx,[bx]	
	call des2	;Desplegar como entero base 10.
	dec bx
	loop lop 
    ret
fin:
	.exit 0
end

