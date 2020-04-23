.model small
extrn des4:near
extrn lee2:near
extrn reto:near
.stack
.data
.code

multi8 macro num1,num2
    
    mov al,num1
    mov bl,num2
    mul bl
    mov dx,ax
    call reto
    call des4
    
endm
main:
    call lee2
    mov bl,al
    call reto
    call lee2
    multi8 al bl

    .exit
end
