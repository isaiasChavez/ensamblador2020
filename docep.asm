.model small
extrn reto:near
extrn lee2:near
extrn des4:near
extrn des2:near
.stack
.data
num db 0
num2 db 0
.code
main:	
    mov ax,@data
	mov ds,ax

    call lee2
	mov bh,al	;primero, alta
	call lee2
	mov bl,al	;primero baja
                ;bx ya está ocupado

 	call lee2
	mov num,al	;primero, alta
    call reto   ;imprime salto de linea
    
    
;////////////////////////////
    push bx
    
	call lee2
    mov ah,al
    call lee2
	mov bx,ax

    call lee2
	mov num2,al

    mov ax,bx
    pop bx

    mov cl,num2
    adc num,cl

	adc ah,bh	;primera suma
	add al,bl	;segunda suma, resultado en carry y AX
    
    call reto

	jnc sigue
	push ax
	mov ah,02h
	mov dl,'1'
	int 21h
	pop ax

sigue:
    mov dl,num
    call des2

    mov dx,ax
	call des4
        
	.exit
end