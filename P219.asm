.model small
extrn des2:near
extrn reto:near
.stack
.data
.code
suma macro num1,num2
add num1,num2
endm
repeletra macro letra,repe
local rlsalto

    mov ah,02h
    mov dl,letra
    mov cx,repe
rlsalto:
    int 21h
    loop rlsalto

endm
    



main:
    mov ax,@data
	mov ds,ax
    mov al,4
    mov bl,3
    suma al bl ;Los parámetros se separan con espacio
    mov dl,al
    call des2
    call reto

    ;SEGUNDO EJEMPLO
    repeletra 41h 5h;Repite 5 veces la letra 'A'
    call reto
    repeletra 'B' 0Ah;Repite 10 veces la letra 'B'
    .exit
end
