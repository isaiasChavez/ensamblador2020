.model small
extrn		des4:near
extrn		reto:near
extrn		leerc:near
extrn		des2:near
extrn		des4:near

.stack
.data
fid		dw ?		;Aquí se guardará el identificador de archivo
narchivo	db "texto.txt",0h
buf db 10		;Aquí enviará tamaño máximo

.code
main:	
    mov ax,@data
	mov ds,ax
	mov es,ax
    
   
	;Crear y abrir
	;fid=fopen( "texto.txt", "w" );
	mov ah,3Ch		;Función para crear archivo.
	mov cx,0		;Archivo normal.
	mov dx,offset narchivo	;Dirección donde está el nombre.
	int 21h			;Crear y abrir, devuelve identificador.
	jc error		;Saltar en caso de error.
	mov fid,ax		;guardar identificador en variable.
	
	;Escribir en el archivo
	;fwrite( &contenido, srtlen( contenido ), 1, fid );
    ;::::::::::
leer: 
    mov dx,offset buf
	mov ah,0Ah
	int 21h

	lea bx,buf
	mov dx,[bx + 2]
    mov cx,[bx + 1]
    mov dh,00
    cmp dl,0Dh
    jz cerrar
   

    add bx,02h
	add bl,cl
	mov [bx],24h
    

	mov ah,40h		;Función para escribir en archivo.
	mov bx,fid		;Identificador.
	mov ch,00  
	lea dx,[buf + 2]	;Dirección búfer.
	int 21h			;Escribir.
    

	jc error		;Saltar en caso de error.
	mov dx,ax
	call des4
	call reto		;Desplegar cuántos bytes se escribieron
    jmp leer

cerrar:
	;Cerrar archivo
	;fclose( fid );
	mov ah,3Eh		;Funcíón para cerrar archivo
	mov bx,fid		;Identificador.
	int 21h			;Cerrar archivo
	jc error		;Saltar en caso de error
	jmp salida
    error:	mov dx,ax		;Desplegar código de error
	call des4
	.exit 1			;Y salir indicando que hubo error
 salida:.exit 0			;Salir sin indicar error
end