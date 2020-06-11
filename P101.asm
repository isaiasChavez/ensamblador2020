; 3. Hacer programa que lea un dígito del teclado, y si es menor que 6,
; desplegar "ya valiste queso".
;Ejemplo:
;4
;ya valiste queso
;8
;(no despliega nada)
;4. Agregar al programa anterior que si el dígito es mayor o igual que 6, desplegar "eres supermán".
;Ejemplo:
;8
;eres superman
.MODEL SMALL
.STACK
.DATA

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
        mov bl,6H      
        int 21h

        sub al,30h
        cmp al,9h
        jle l1s
        sub al,7h ;Me deja el resultado en al
l1s:
        cmp al,bl
        ja dsu ;menor que 6
        je dsu 
        jb dqu ;igual o Mayor que 6
        

dsu:
    mov ah,09h
    lea dx,superman 
    int 21h
    .exit  
dqu:
    mov ah,09h
    lea dx,queso 
    int 21h
    .exit
end