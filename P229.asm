.model small
.386

extrn reto:near
extrn des2:near

.stack
.data


buf	db	8		;Aquí enviará tamaño máximo

dbfin	db 24h	
.code
main:	
	mov ax,@data
	mov ds,ax
	lea dx, buf
	mov ah,0Ah
	int 21h
	call reto
	
	lea bx,buf
	mov dx,[bx+1]
	mov cx,[bx+1]
	add bx,02h
	call des2
	call reto

	add bl,cl
	mov [bx],24h
	lea dx,[buf + 2] 
	mov ah,09h
	int 21h

	call reto
	.exit	


end

 
