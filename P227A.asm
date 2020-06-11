.model small
.data
arr1 db "minlalaminino "
arr2 db "minino"
.code
main: mov ax,@data
mov ds,ax
mov es,ax 
cld
mov si,offset arr1
mov di,offset arr2  
    
     
mov cx,0Ah
ci:
mov bx,si  
mov dx,cx
   
push cx
mov cx,6h
rep  cmpsb  
mov di,offset arr2 
je difer  
pop cx
  
mov si,bx   
inc si 
loop ci   
    
            
salto:
.exit   

difer:  
        mov cx,dx
        mov dx,9h 
        sub dx,cx  
        add dx,31h   
        mov ah,02h
        int 21h
        jmp salto    
    .exit
end 