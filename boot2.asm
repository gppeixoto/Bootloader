org 0x500
jmp 0x0000:start

string1 db 'Loading structures for the kernel...', 13, 10, 0 ; (carriage return, pula linha e 0 no fim)
string2 db 'Setting up protected mode...', 13, 10, 0
string3 db 'Loading kernel in memory...', 13, 10, 0
string4 db 'Running kernel...', 13, 10, 0

start:

	xor ax, ax
	mov ds, ax

	xor si, si
	mov si, string1		;primeira string
	call print			;printa e dá uma pausa, para dar uma ilusão de "carregando..."
	call pause
	
	xor si, si
	mov si, string2		;segunda string
	call print
	call pause

	xor si, si
	mov si, string3		;terceira string
	call print
	call pause
	
	xor si, si
	mov si, string4		;quarta string
	call print
	call pause

reset:			;leitura do disco
	mov ah, 0 
	mov dl, 0
	int 13h		;interrupcao reset drive, head 0 na trilha 0 de todos os drives
	jc reset	;se houve erro (no cf), tenta de novo a operação 

	mov ax, 0x7e0
	mov es, ax		
	xor bx, bx		;es:bx é o segment:offset

leitura:
	mov ah, 0x02
	mov al, 16		;#setores
	mov ch, 0		;trilha 0
	mov cl, 3		;setor 2
	mov dh, 0		;head 0
	mov dl, 0		;drive 0
	int 13h
	jc leitura		;se detectou erro no cf, tenta de novo

jmp 0x7e0:0x0

print:				;si=endereço inicial, lodsb--> al=[si]; si++
	lodsb			;carrega si em al
	cmp al, 0		;achou o fim, encerra o print
	je fimPrint	
	mov ah,	0eh	
	int 10h			;interrupcao de print
	jmp print
	
fimPrint:
ret

pause:				
	mov ah, 86h		;interrupcao de wait
	mov cx, 50		;tempo cx em milissegundos, dx em microssegundos
	mov dx, 0		;obs: tempo varia de acordo com a máquina e com quantos processos estão abertos, não
	int 15h				;é exatamente "determinístico"
ret

