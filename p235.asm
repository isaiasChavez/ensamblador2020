.model small


.stack
.data
numx db ?
contar db 60
numy db ?

.code
main:	;Leer configuración de pantalla y guardarla en la pila
	mov ah,0fh	;Función leer modo.
	int 10h
	push ax		;Guardar modo en la pila.
	;Definir pantalla 640x480, 16 colores
	mov ax,0012h	;Función establecer modo.
	int 10h

    mov numx,32h
    mov numy,32h

    mov cl,numx
    mov dl,numy
    mov dh,0
    mov ch,0        
        
reg:    
    inc cx
    inc dx
    call color   
    cmp cl,64h
 
    
    je NEXT
    jmp reg

NEXT:      
    inc dx
    dec cx
    call color 
    cmp cx,32h
    je next1 
    jmp next
 
color:
    mov ah,0ch
    mov al,09h
    int 10h
    ret

next1:
    dec cx
    dec dx
    call color   
    cmp cx,0
 
    
    je NEXT2
    jmp next1
    
NEXT2: 
    
    dec dx
    inc cx
    call color 
    cmp dx,32h
    je fin 
    jmp next2
    
fin:   
	;Esperar usuario (para que no termine sin poder ver)
	mov ah,00h
	int 16h
	;Restaurar pantalla
	pop ax		;Modo original en la pila.
	mov dl,al
	mov ah,0	;Función establecer modo
	int 10h		;Establecer. Queda como al principio.
 	.exit 0
end