;1. Verificar que nos quedó el programa del alfabeto de la actividad 1.
 ;Les mostraré un algoritmo en seudocódigo que hace lo mismo, si les puede servir:

.MODEL SMALL
.STACK
.DATA

final db ?
actual db,?
destino db ?

blanco db ' ','$';
.CODE
main: mov ax,@data
      mov ds,ax
    mov final,'Z'
    mov destino,'A'
l1: mov actual,'A'
    
   
      
l2: mov ah,02h
    mov dl,actual
    int 21h
    inc actual
    mov bl,actual
    mov bh,destino
    cmp bl,bh
    jl l2
    inc destino
    lea dx,blanco
    mov ah,09h
    int 21h
    mov bl,destino
    mov bh,final
    cmp bl,bh
    jl l1
    
.exit



end