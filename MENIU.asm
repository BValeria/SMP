
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
mov ax,0600h         ;Scroll
mov bh,07
mov cx,0000
mov dx,184fh
int 10h              ;Intrerupere: Goleste ecran 

mov ah,00
mov al,13h
int 10h              ;Intrerupere: Schimbare mod

;Desenare linie sus casa
mov cx,130           ;Coloana de inceput este 130
mov dx,75            ;Linia de inceput este 75

Top:
mov ah,0ch           ;Deseneaza o linie
mov al,07h           ;Pixelul va fi gri deschis
int 10h              
inc cx               ;Incrementeaza pozitia orizontala
cmp cx,216           ;Se continua linia pana se ajunge la coloana 216
jnz Top             ;Continua daca nu s-a ajuns la coloana 216

;Desenare linie jos casa
mov cx,130           ;Coloana de inceput este 130
mov dx,125           ;Linia de inceput este 125

Bottom:
mov ah,0ch
mov al,07h
int 10h
inc cx 
cmp cx,216
jnz Bottom

;Desenare linie verticala stanga casa
mov cx,130           ;Coloana de inceput este 130
mov dx,75            ;Linia de inceput este 75
Left:
mov ah,0ch
mov al,07h
int 10h
inc dx 
cmp dx,125
jnz Left

;Desenare linie verticala dreapta casa
mov cx,216           ;Coloana de inceput este 216
mov dx,75            ;Linia de inceput este 75
Right:
mov ah,0ch
mov al,07h
int 10h
inc dx 
cmp dx,126
jnz Right

;Desenare linie stanga  acoperis
mov cx, 130
mov dx,75
LeftRoof:
mov ah,0ch
mov al,07h
int 10h
inc cx
dec dx
cmp cx,173
cmp dx,32
jnz LeftRoof

;Desenare linie dreapta acoperis
mov cx,173
mov dx,32 
RighRoof:
mov ah,0ch
mov al,07h
int 10h
inc cx
inc dx
cmp cx,216
cmp dx,75
jnz RighRoof


jmp ShowMenu


Quit:
mov   ah,4ch        ;Functie DOS de Exit
int   21h  

main endp
end main
ret




