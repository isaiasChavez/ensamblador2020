.model small
.386
.387
extrn des2:near
extrn reto:near
extrn	lee1:near
.data
ENTR		dt	0
.code
main:	mov ax,@data
		mov ds,ax
		mov es,ax
		mov dx,offset ENTR
		call desfdec
	
		mov bx,offset ENTR
		add bx,8
		mov cx,9
c1:	mov dx,[bx]
		call des2
		dec bx
		loop c1	
		.exit 0

desfdec:	
		mov ax,'$'		;bandera para ver si la pila esta vacia
		push ax
		mov ax,0
		push ax
		mov cx,19
l2:	    
		mov ah,01
		int 21h
		cmp al,0dh
		je sigue
		mov ah,0
		sub ax,30h
		push ax
		loop l2
sigue:	mov bx,19		
		sub bx,cx
		mov cx,bx
		
		mov ax,cx		
		mov bl,2
		div bl
		cmp ah,1		
		jne cont
		inc al	
cont:	mov ah,0		
		mov cx,ax
		mov bx,offset ENTR
		
lu:	
		pop ax
		mov dx,ax
		pop ax
		shl al,4
		add al,dl
		mov byte ptr[bx],al
		inc bx
		loop lu	
		
npa:	pop ax
		cmp	al,'$'
		jne npa
		
		
		finit 
		fbld ENTR
		fbstp ENTR
		fwait				
		
		ret
end