.model small
.386
.387	;Ahora es necesario también agregar el coprocesador
extrn	reto:near
extrn	des2:near
.stack
.data
RADIOB	dt	10h	;Flotante de 80 bits.
AREAB	dt	0	;32 bits.
AREAC dt 0 
MIL	dt	1000000	;Entero 32 bits.

.code
main:	mov ax,@data
	mov ds,ax
	mov es,ax
	finit		;Inicializar el coprocesador.
	fbld RADIOB ;Carga radio como flotante.
			; Pila: 2.0
	fmul ST,ST(0)	;Multiplica tope de pila consigo mismo.
			; Pila: 4.0
	fldpi		;Carga PI.
			; Pila: 3.1416 4.0
	fmul		;Multiplica elementos superiores.
			; Pila: 12.5664

	fbstp AREAB	;Guardar (resultado x 100),
			; como entero de 32 bits.
	fwait		;Esperar al coprocesador.

	mov bx,offset AREAB
	add bx,1
	mov cx,2
	
lop:
	mov dx,[bx]	;Cargar en DX (16 bits) parte ALTA
			; del resultado.
	call des2	;Desplegar como entero base 10.
	dec bx
	
	loop lop 
	mov dx,46
	mov ah,02h
	int 21h

    fbld AREAB

    fbld RADIOB ;Carga radio como flotante.
			; Pila: 2.0
	fmul ST,ST(0)	;Multiplica tope de pila consigo mismo.
			; Pila: 4.0
	fldpi		;Carga PI.
			; Pila: 3.1416 4.0
	fmul		;Multiplica elementos superiores.
			; Pila: 12.5664


    
    fsub
    fbld MIL	;Cargar 1000000.
	fmul		; Pila: 12566.3706
	
    fbstp AREAB	;Guardar (resultado x 100),
			; como entero de 32 bits.
	fwait		;Esperar al coprocesador.

	mov bx,offset AREAB
	add bx,2
	mov cx,3
	
lop2:
	mov dx,[bx]	;Cargar en DX (16 bits) parte ALTA
			; del resultado.
	call des2	;Desplegar como entero base 10.
	dec bx
	
	loop lop2 

	.exit 0
end