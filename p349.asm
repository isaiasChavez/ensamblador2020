.model small
.386
.387	
extrn	des2:near
extrn	impp:near
.stack
.data
v1 dd 1
v2 dd 2
v4 dd 4
C4 dt 4
n dd 1
SUMA dd 0
PIPI dd 0 
RESULT	dt   ?				
MILL	dt	100000000			
AUX 	dd   ?					 
.code
main:	
		mov ax,@data
		mov ds,ax
		mov es,ax
		mov cx,9000h
ciclo:
		finit		 				;Inicializar el coprocesador.

		fld v1

		fld n

		fdiv
        ;1
		fld v1

		fld n

		fld v2

		fadd

		fdiv
        ;1/3 | 1
		fsub
        ; (1 - 1/3)
		fld SUMA

		fadd

		fstp SUMA
        ; sumt = 2/3 pila vacia
		fwait						;Esperar al coprocesador.

cambios:
		finit

		fld n

		fld v4

		fadd

		fstp n

		fwait

loop ciclo

		finit

		fld SUMA ;Se carga la suma total
		fbld C4 ;Se carga la multiplicación
		fmul    
		fstp PIPI ;Se descarga el resultado
		fwait
		mov dx,offset PIPI
		call desFDec
		.exit 0

desFDec:
 	mov di,offset AUX			
 	mov si,dx					
 	cld 						
 	mov cx,4
 	rep movsw
	finit		 				
	fld AUX													
	fbld MILL					
	fmul						
	fbstp RESULT					
	fwait						
	mov bx,offset RESULT				
 	add bx,7				
 	mov cx,4
c1: 						
	mov dx,[bx]
	cmp dx,0
	jz sigue
	call des2
sigue:	
	dec bx
	loop c1
    call impp
	mov cx,05
c2:							;Ciclo para imprimir la parte flotante.
	mov dx,[bx]
	call des2
	dec bx
	loop c2
end