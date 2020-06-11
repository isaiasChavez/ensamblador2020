.model small
.386
.387	;Ahora es necesario también agregar el coprocesador
extrn	reto:near
extrn	des4:near
.stack
.data
RADIO	dd	2.0	;Flotante de 32 bits.
AREA	dd	?	;32 bits.
MIL	dd	100000000	;Entero 32 bits.
AREAINT dd	?	;Resultado entero por 1000.
.code
main:	mov ax,@data
	mov ds,ax
	mov es,ax
	finit		;Inicializar el coprocesador.
	fld RADIO	;Carga radio como flotante.
			; Pila: 2.0
	fmul ST,ST(0)	;Multiplica tope de pila consigo mismo.
			; Pila: 4.0
	fldpi		;Carga PI.
			; Pila: 3.1416 4.0
	fmul		;Multiplica elementos superiores.
			; Pila: 12.5664
	fst AREA	;Guardar resultado en variable,
			; sin extraer de la pila.
	fild MIL	;Cargar 1000.
	fmul		; Pila: 12566.3706
	fistp AREAINT	;Guardar (resultado x 1000),
			; como entero de 32 bits.
	fwait		;Esperar al coprocesador.
	mov bx,offset AREAINT
	mov dx,[bx+2]	;Cargar en DX (16 bits) parte ALTA
			; del resultado.
	call des4	;Desplegar como entero base 10.
	mov dx,[bx]	;Cargar en DX (16 bits) parte BAJA
			; del resultado.
    call des4	;Desplegar como entero base 10.
	call reto        
	.exit 0
end