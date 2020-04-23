.model small
extrn reto:near
extrn lee2:near
extrn des2n:near
.stack
.data
msg db 10,13,'Si es negativo',10,13,'$'
guion db 10,13,'-','$'
.code
main proc
   mov ax,@data
	mov ds,ax

    call lee2
    mov dl,al
    call des2n

	.exit
    main ENDP
end