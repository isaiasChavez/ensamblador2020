; A > B JG
; A < B JL
; A = B JE


.model small
.386
extrn reto:near
extrn des2:near
extrn lee2:near
extrn lee4:near
.stack
.data
arreglo db "BBBBABBABA"
.code
print	macro cadena
local dbcad,dbfin,salta
	pusha			;respalda todo
	push ds			;respalda DS, porque vamos a usar segmento de código
	mov dx,cs		;segmento de código será también de datos
	mov ds,dx
	
	mov dx,offset dbcad	;dirección de cadena (en segmento de código)
	mov ah,09h
	int 21h			;desplegar
	jmp salta		;saltar datos para que no sean ejecutados
 dbcad	db cadena		;aquí estará la cadena pasada en la sustitución
 dbfin	db 24h			;fin de cadena
salta:	pop ds			;etiqueta local de salto, recuperar segmento de datos
	popa			;recuperar registros
endm

main:	
    mov ax,@data
	mov ds,ax
	mov es,ax
	mov al,'A'	;Carácter que se busca.
	mov cx,10	;Número de veces a buscar .
	cld		;Búsqueda ascendente.
	mov di,offset arreglo
NOCERO:    
	repne scasb	;Repetir mientras CX>0 y el dato
			; sea diferente a lo de AL.
	jne fin	;Saltar si la última comparación hecha
			; con scasb no dio “igual”.

	print " Posicion: "
    push ax
    mov AX,000AH
    sub AX,CX
    MOV dx,ax
    CALL des2
    pop ax   
    CALL reto
 fin:	
    cmp cx,0H
    JNE NOCERO
    print "Termino"

 
 .exit 0

 end