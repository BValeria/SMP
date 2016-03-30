
org 100h

.model small
.stack 100h

.data 

;Afisare meniu
msg1    db      10, 13, 10, 13, "Please select an item:",0Dh,0Ah,0Dh,0Ah,09h
 db     "1- Show Project Description",0Dh,0Ah,09h     
 db     "2- Show drowing",0Dh,0Ah,09h 
 db     "3- Exit",0Dh,0Ah,09h
 db     "Enter item number: "
 db     '$'  

About   db      10, 13, 10, 13, "Text about the project!$"

.code

main proc
 mov    ax,@data   ;Se incarca adresa datelor (optiunea aleasa)
 mov    ds,ax      ;Se copiaza in registrul de segmentpentru a se putea accesa datele

ShowMenu:      
 lea     dx, msg1   ;Obinerea adresei variabilei
 mov     ah, 09h
 int     21h        ;Intrerupere pentru operatia de INPUT    

GetNum:       
mov     ah, 1       ;Citire caracter (optiunea aleasa)
int     21h       

cmp     al, "1"     ;Verificare daca s-a ales optiunea1
je      ShowAbout   ;Jump daca primul operator este egal cu 1
 
cmp     al, "2"     ;Verificare daca s-a ales optiunea2
je      ShowPainting
 
cmp     al, "3"     ;Verificare daca s-a ales optiunea3
jmp     Quit

Showabout:      
lea     dx, About   ;Obtinere adresa About
mov     ah, 09h     ;Functie de display
int     21h   
jmp     ShowMenu 

ShowPainting:

int     21h   
jmp     ShowMenu


Quit:
mov   ah,4ch        ;Functie DOS de Exit
int   21h  

main endp
end main
ret




