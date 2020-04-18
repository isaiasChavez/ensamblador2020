.MODEL SMALL
.STACK
.DATA
seis db 6
queso db "Ya valiste queso$"

superman db "Eres superman$"
men db "Ingrese un numero $"

.CODE


main:   mov ax,@data
        mov ds,ax
        
        mov ah,09
        lea dx,men
        int 21h

        mov ah,01
        mov bl,seis
        int 21h
        cmp al,bl

        je dqu ;IGUALES
        jge dsu
dqu:
    mov ah,09h
    lea dx,queso 
    int 21h
    .exit
dsu:
    mov ah,09h
    lea dx,superman 
    int 21h
    .exit  

end