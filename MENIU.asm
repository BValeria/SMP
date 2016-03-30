
org 100h

.model small
.stack 100h
.data

msg1    db      10, 13, 10, 13, "Please select an item:",0Dh,0Ah,0Dh,0Ah,09h

 db      "1- Show Project Description",0Dh,0Ah,09h     
 db      "2- Show drowing",0Dh,0Ah,09h 
  db     "3- Exit",0Dh,0Ah,09h
 db      "Enter item number: "
 db      '$'  
About   db      10, 13, 10, 13, "Text about the project!$"

handle  dw  ?
file1   db  "test.txt", 0
text    db  "test text",0
text_size equ $ - text


.code

main proc
 mov    ax,@data
 mov    ds,ax

ShowMenu:      
 lea     dx, msg1 
 mov     ah, 09h
 int     21h    

getnum:       
mov     ah, 1
int     21h       

cmp     al, "1"
je      ShowAbout
 
cmp     al, "2"
je      ShowPainting
 
cmp     al, "3"
jmp     Quit


Quit:
mov   ah,4ch
int   21h  

Showabout:      
lea     dx, About 
mov     ah, 09h
int     21h   
jmp     ShowMenu 

ShowPainting:

int     21h   
jmp     ShowMenu

main endp

end main
ret




