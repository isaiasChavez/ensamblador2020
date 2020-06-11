                                                  .model small


.stack
.data
numx db ?
cora db ? 
corb db ? 
corc db ?
numy db ?

.code
main:	;Leer configuración de pantalla y guardarla en la pila
	mov ah,0fh	;Función leer modo.
	int 10h
	push ax		;Guardar modo en la pila.
	;Definir pantalla 640x480, 16 colores
	mov ax,0012h	;Función establecer modo.
	int 10h
            
    mov cora,32h
    mov corb,64h
    mov corc,32h            
                
              
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
    cmp cl,corb
    
    je NEXT
    jmp reg
    

NEXT:
  
    dec cora
    dec corb
    inc corc
    mov cl,cora
    mov dl,corc
    call color 
    cmp dx,64h
    je fin 
    jmp reg
 
color:
    mov ah,0ch
    mov al,09h
    int 10h
    ret

    
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