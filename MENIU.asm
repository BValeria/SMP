
org 100h

.model small
.stack 100h

.data 

;Afisare meniu
msg1    db      10, 13, 10, 13, "Please select an item:",0Dh,0Ah,0Dh,0Ah,09h
 db     "1- Show Project Description",0Dh,0Ah,09h     
 db     "2- Show drawing",0Dh,0Ah,09h    
 db     "3- Play",0Dh,0Ah,09h
 db     "4- Exit",0Dh,0Ah,09h
 db     "Enter item number: "
 db     '$'  

enter db 13, 10,13,10, " $"  
deplasare equ 5 
.code
 
mov ax,@data        ;Se incarca adresa datelor (optiunea aleasa)
mov ds,ax           ;Se copiaza in registrul de segmentpentru a se putea accesa datele

ShowMenu:  
mov ah, 02
mov dl, 07h         ;07h valoarea ce produce beep-ul
int 21h             ;Se produce sunetul  
  
lea dx, msg1        ;Obinerea adresei variabilei
mov ah, 09h    
int 21h             ;Intrerupere pentru operatia de INPUT    

GetNum:       
mov ah, 1           ;Citire caracter (optiunea aleasa) 
int 21h
 

cmp al, "1"         ;Verificare daca s-a ales optiunea1  
je  ShowAbout       ;Jump daca primul operator este egal cu 1
 
cmp al, "2"         ;Verificare daca s-a ales optiunea2
je  ShowPainting1       

cmp al, "3"         ;Verificare daca s-a ales optiunea3
je  Play

cmp al,"4"          ;Verificare daca s-a ales optiunea4
jmp Quit   

Showabout: 
mov ah, 09          ;Inserare linie noua
mov dx, offset enter;enter
int 21h
      
mov dx, offset file ;Se salveaza adresa fisierului in dx
mov al,0            ;Atributul de read-only
mov ah,3Dh          ;3Dh salveaza handler-ul automat in ax
int 21h 

mov bx,ax           ;put handler to file in bx
mov cx,1            ;Citeste cate un caracter  

print:
lea dx, BUF
mov ah,3fh           ;Citeste din fisierul deschis (its handler in bx)
int 21h
cmp ax, 0            ;Verifica numarul de bytes transferati
je ShowMenu 

mov al, BUF 
mov ah,0eh           ;Afiseaza caracter (teletype).
int 10h
jmp print            ;Citeste si afiseaza pana la sfarsitul fisierului.

file db "test1.txt"
BUF db ?

ShowPainting1:
mov ah,00
mov al,13h           ;codul seviciului video 
int 10h              ;Schimbare in mod grafic :servicii video

;Desenare linie sus casa
mov cx,130           ;Coloana de inceput este 130
mov dx,75            ;Linia de inceput este 75

Top:
mov ah,0ch           ;Deseneaza o linie
mov al,07h           ;Pixelul va fi gri deschis
int 10h              
inc cx               ;Incrementeaza pozitia orizontala
cmp cx,216           ;Se continua linia pana se ajunge la coloana 216
jnz Top              ;Continua daca nu s-a ajuns la coloana 216

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

;Desenare linie stanga usa 
mov cx,164
mov dx,125 
LeftDor:
mov ah,0ch
mov al,07h
int 10h
dec dx
cmp dx,100
jnz LeftDor 

;Desenare linie dreapta usa 
mov cx,182
mov dx,125 
RightDor:
mov ah,0ch
mov al,07h
int 10h
dec dx
cmp dx,100
jnz RightDor

;Desenare linie sus usa 
mov cx,164
mov dx,100 
TopDor:
mov ah,0ch
mov al,07h
int 10h
inc cx
cmp cx,183
jnz TopDor

;Desenare linie verticala1 fereastra stanga
mov cx,151
mov dx,95
LeftWindow1:
mov ah,0ch
mov al,07h
int 10h
dec dx
cmp dx,85
jnz LeftWindow1

;Desenare linie verticala2 fereastra stanga
mov cx,143
mov dx,95
LeftWindow2:
mov ah,0ch
mov al,07h
int 10h
dec dx
cmp dx,85
jnz LeftWindow2

;Desenare linie verticala3 fereastra stanga
mov cx,135
mov dx,95
LeftWindow3:
mov ah,0ch
mov al,07h
int 10h
dec dx
cmp dx,85
jnz LeftWindow3

;Desenare linie orizontala1 fereastra stanga 
mov cx,135
mov dx,85
LeftWindow4:
mov ah,0ch
mov al,07h
int 10h
inc cx
cmp cx,151
jnz LeftWindow4

;Desenare linie orizontala2 fereastra stanga
mov cx,135
mov dx,90
LeftWindow5:
mov ah,0ch
mov al,07h
int 10h
inc cx
cmp cx,151
jnz LeftWindow5
 
;Desenare linie orizontala3 fereastra stranga
mov cx,135
mov dx,95
LeftWindow6:
mov ah,0ch
mov al,07h
int 10h
inc cx
cmp cx,151
jnz LeftWindow6 


;Desenare linie verticala1 fereastra dreapta
mov cx,195
mov dx,95
RightWindow1:
mov ah,0ch
mov al,07h
int 10h
dec dx
cmp dx,85
jnz RightWindow1

;Desenare linie verticala2 fereastra dreapta
mov cx,203
mov dx,95
RightWindow2:
mov ah,0ch
mov al,07h
int 10h
dec dx
cmp dx,85
jnz RightWindow2

;Desenare linie verticala3 fereastra dreapta
mov cx,211
mov dx,95
RightWindow3:
mov ah,0ch
mov al,07h
int 10h
dec dx
cmp dx,85
jnz RightWindow3

;Desenare linie orizontala1 fereastra dreapta
mov cx,195
mov dx,85
RightWindow4:
mov ah,0ch
mov al,07h
int 10h
inc cx
cmp cx,211
jnz RightWindow4

;Desenare linie orizontala2 fereastra dreapta
mov cx,195
mov dx,90
RightWindow5:
mov ah,0ch
mov al,07h
int 10h
inc cx
cmp cx,211
jnz RightWindow5
 
;Desenare linie orizontala3 fereastra dreapta
mov cx,195
mov dx,95
RightWindow6:
mov ah,0ch
mov al,07h
int 10h
inc cx
cmp cx,211
jnz RightWindow6

mov ah,01h       ;Asteptare caracter
int 21h

mov ah,00h       ;Golire ecran
mov al,03h       ;Trecere in mod text
int 10h  

jmp ShowMenu 

Play:
mov ah, 0h      ;setting video mode
mov al, 03h     ;text mode, 80x25    
int 10h
call colorare
mov ch, 0       ;De unde incep sa desenez patratul
mov cl, 0
mov dh, 5       ;Dimensiunile patratului
mov dl, 5 
push cx         ;Salvam coordonatele 
push dx
mov bh, 0eeh    ;Schimbare culoare patrat in galben
int 10h

choose:
;Alege directie deplasare
mov ah, 1
mov bh, 32
int 21h
cmp al, 'e'
je menu
cmp al, 'r'
je R 
cmp al, 'l'
je L

R: 
;Deplasare spre dreapta
call colorare
mov bh, 0eeh           ;Culoarea patratului devine galben
mov ch, 0              ;Deplasarea se face pe aceeasi linie
pop dx                 ;Verific ultima pozitie (pe verticala) a patratului
add dl, deplasare      ;Adaug deplasare
pop cx 
add cl, deplasare
mov dh, 5              ;Mentinerea dimensiunii
push cx                ;Salvare coordonate 
push dx
int 10h
call beep 
jmp choose 

L:
;deplasare spre stanga
call colorare 
mov bh, 0eeh
mov ch, 0
pop dx
sub dl, deplasare
pop cx 
sub cl, deplasare
mov dh, 5
push cx
push dx
int 10h
call beep
jmp choose 

menu: 
;Revenire la meniu       

mov ah,00h          ;Golire ecran   
mov al,03h          ;Trecere in mod text
int 10h  
jmp ShowMenu

beep PROC
;Realizare sunet  
mov ah,02
mov dl, 07h         ;07h valoarea ce produce beep-ul
int 21h             ;Se produce sunetul
ret
beep ENDP 

colorare PROC ; coloreaza fundalul cu verde
mov al, 0  
mov ah, 6
mov bh, 0h          ;Colorare ecran negru
mov ch, 0           ;De unde se seteaza ecranul
mov cl, 0 
                     
mov dh, 25          ;Dimensiuni ecran
mov dl, 80 
int 10h 
ret 
colorare ENDP 

Quit:
mov ah,4ch           ;Functie DOS de Exit
int 21h  


ret









