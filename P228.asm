.model small
extrn des1:near 
extrn reto:near
extrn lee2:near
extrn des1:near
.data
arr1 db " minino de saca minino "
arr2 db "minino"
.code
main: mov ax,@data
mov ds,ax
mov es,ax ;Sean ambos el mismo segmento.
cld
mov si,offset arr1
mov di,offset arr2  
    
     
mov cx,0Fh
cila:
mov bx,si  
mov dx,cx
   ;;;     
    push cx
    mov cx,6h
         rep  cmpsb  
         mov di,offset arr2 
        jne difer  
            mov cx,0Fh 
            sub cx,dx
            mov dx,cx
            call des1  
            
            mov ah,02h 
            mov dl,' '
            int 21h  
        difer: 
    pop cx
     ;;;;;;;;;;
     mov si,bx   
    inc si 
loop cila   
    
.exit     
          
  
end 