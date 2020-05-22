.model small
extrn		des4:near
extrn		reto:near
extrn		despc:near

.stack
.data
patron	db	"*.*",0		;Cualquier archivo
DTA	db	21 dup(0)
attr	db	0
time	dw	0
date	dw	0
sizel	dw	0
sizeh	dw	0
fname	db	13 dup(0)
.code
main:	mov ax,@data
	mov ds,ax
	mov es,ax
	
	;establecer posición de DTA
	mov ah,1Ah
	mov dx,offset DTA	;Establece posición del inicio del DTA
	int 21h
	
	;Preparar lectura de directorio y carga datos del primer archivo
	mov dx,offset patron	;Patrón de búsqueda
	mov cx,0		;Archivos normales
	mov ah,4Eh		;Buscar primer archivo que cumpla
	int 21h
	jc sale
	
	;Desplegar nombre (también se podrían desplegar otros datos)
	push offset DTA
	call despc
	add sp,02
	call reto
	
	;Mostrar el resto de los archivos
 nf:	mov ah,4Fh
	int 21h
	jc sale
	push offset fname
	call despc
	add sp,02
	call reto
	jmp nf
 sale:	.exit 0
 erro:	.exit 1

 end