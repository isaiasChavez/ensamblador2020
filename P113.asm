.model small
;FINAL
extrn reto:near
extrn lee2:near
extrn des4:near
extrn des2:near
extrn desm:near
extrn lee4:near
.stack
.data

msg db 10,13,'Segunda multiplicacion ',10,13,'$'
.code
main proc
    mov ax,@data
	mov ds,ax

    call lee2
    mov bl,al
    call reto
    call lee2
    mul bl
    mov dx,ax
    call reto
    call des4

    lea dx,msg
    call desm

    call reto
    call lee4
    
    mov cx,ax
    call lee4
    
    MUL cx
    call reto
    call des4
    mov dx,ax
    call des4
      




	.exit
    main ENDP
end
;Actividad #13, Abril 13
;En los apuntes sección "10. Más operaciones aritméticas y lógicas" está la sección de multiplicación y división.
;La multiplicación opera sobre el registro A y algún otro, y lo puede hacer de 8 a 16 bits, o de 16 bits a 32. Las multiplicaciones producen valores más grandes (excepto si es por 1 o por 0) así que el resultado se espera en un registro mayor.
;Si la operación es de 8 bits por 8 bits, uno de los términos está AL y el otro en un registro de 16 bits. Por ejemplo 'MUL BL' hará AL*BL y el resultado, de 16 bits, quedará en AX. El resultado siempre irá al registro A, así que se borrará el valor anterior.
;Si la operación es de 16 bits por 16 bits, uno de los términos está AX y el otro en un registro de 16 bits. Por ejemplo 'MUL CX' hará AX*CX y el resultado, de 32 bits, quedará en el par DX-AX. En este caso, el resultado no cabe en AX, así que el resultado se divide entre ambos registros, teniendo DX la parte alta.
;1. Hacer programa que lea 2 números de 8 bits (usando dos veces lee2), multiplicarlos, y mostrar el resultado usando des4.
;2. Hacer programa que lea 2 números de 16 bits (usando dos veces lee4), multiplicarlos, y mostrar el resultado usando dos veces des4.