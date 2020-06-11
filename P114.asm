;Actividad #14, Abril 14
;Ahora procederemos con la división. Es un poco más difícil que la multiplicación.
;La división opera sobre el registro A y algún otro, y produce dos resultados más chicos: cociente y residuo. La división se puede efectuar de 16/8 bits con resultados de 8 bits, o de 32/16 bits con resultados de 16 bits. Las divisiones producen valores más chicos (excepto si es por 1 o por 0, en cuyo caso produce una interrupción) así que el resultado se espera en dos registros menores. Son dos registros porque además del cociente entero produce el residuo.
;Si la operación es de 16 bits entre 8 bits, el dividendo está AX y el divisor en un registro de 8 bits. Por ejemplo 'DIV BL' hará AX/BL, cociente en AL y residuo quedará en AH.
;Si la operación es de 32 bits enter 16 bits, el dividendo está DX-AX y el divisor en un registro de 16 bits. Por ejemplo 'DIV CX' hará DX-AX/CX, cociente en AX y residuo en DX.
;Es muy importante que el programador tenga conciencia del posible tamaño del resultado. Por ejemplo, si se pretende dividir FFFFh/0Ah (16 bits/8 bits), el resultado es 1999h, que no cabe en 8 bits. La operación tendría que hacerse a 32 bits, es decir: 0000FFFFh/000A para que su resultado pueda caber.
;1. Hacer programa que lea un número de 16 bits y otro de 8 bits (usando lee4 y lee2), dividirlos, y mostrar el cociente y el residuo usando des2.
;2. Hacer programa que lea un número de 32 bits y otro de 16 bits (usando lee4), dividirlos, y mostrar el cociente y el residuo usando des4.
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

msg db 10,13,'Segunda division ',10,13,'$'
.code
main proc
    mov ax,@data
	mov ds,ax

    call lee2
    mov bl,al

    call reto

    call lee4
    DIV bl ;'DIV BL' hará AX/BL, cociente en AL y residuo quedará en AH.
    call reto

    mov dl,al
    call des2
    mov dl,ah
    call reto
    call des2
    call reto
    lea dx,msg
    call desm
;Si la operación es de 32 bits enter 16 bits, 
;el dividendo está DX-AX y el divisor en un registro de 16 bits.
; Por ejemplo 'DIV CX' hará DX-AX/CX, cociente en AX y residuo en DX.

    call lee4
    mov cx,ax
    call reto

    call lee4
    mov dx,ax
    call lee4

    div cx
    push dx
    mov dx,ax

    call reto
  
    call des4
    pop dx
    call reto
    call des4




	.exit
    main ENDP
end