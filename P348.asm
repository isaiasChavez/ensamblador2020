.model small
.386
.387	;Ahora es necesario también agregar el coprocesador
extrn	reto:near
extrn	leed:near
extrn	desFDec:near
extrn	RES:near
extrn desidec:near
.stack
.data
cxx db	0
RESj dt 0

E1	dd ?					;Declaramos 3 variables para guardad los 3 valores leídos
E2	dd ?
E3	dd ?
RESF dd ?					;Declaramos esta variable para guardar el resultado
prueba dd 12.45
.code
main:	mov ax,@data
		mov ds,ax
		mov es,ax

		mov bx,offset E1	;Aquí hacemos uso de la función de lectura para guardar 
		call leed		;datos leídos por el teclado a las variables
		mov dx,offset E1
		call desidec		

		mov bx,offset E2
		call leed
		mov dx,offset E2
		call desidec		

		mov bx,offset E3
		call leed
		mov dx,offset E3
		call desidec	
				
		finit				;Inicializar el coprocesador.

		fild E1  			;Cargamos el primer valor

		fild E2  			;Cargamos el segundo valor

		fsqrt 				;Sacamos raíz cuadrada al elemento E2. Pila: SQRT(E2) | E1

		fadd				;Sumamos ambos elementos de la pila. Pila: (SQRT(E2)+E1)

		fmul ST,ST(0)		;Multiplicamos el único elemento de la pila por sí mismo. Pila: (SQRT(E2)+E1)^2

		fild E1				;Cargamos el primer valor. Pila: E1 | ((SQRT(E2)+E1)^2)

		fild E3 			;Cargamos el tercer valor. Pila E3 | E1 | ((SQRT(E2)+E1)^2)

		fsub				;Restamos los dos elementos que están más al tope. Pila: (E3-E1) | ((SQRT(E2)+E1)^2)

		fdiv				;Dividimos los elementos de la pila ((SQRT(E2)+E1)^2)/(E3+E1)

		fstp prueba			;Sacamos el resultado en una variable dd
		fwait				;Esperar al coprocesador.
		
		mov dx,offset prueba 	;Apuntamos con dx a el resultado.
		call desiDec		;Llamamos la función de despliegue con punto decimal. Con esto tenemos ya el resultado en pantalla.

		jmp fin

		


fin:
.exit 
end