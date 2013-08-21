org 0x7c00 
jmp 0x0000:start

start:
	
	xor ax, ax ;limpando
	mov ds, ax

clean: 
	mov ah, 0	
	mov dl, 0
	int 13h 	;interrupcao de diskaccess
	jc clean 	;tenta de novo se detectou erro no cf

 	mov ax, 0x50	
	mov es, ax		;es:bx vai ficar o segment:offset
	xor bx, bx	


lendo:
	mov ah, 2 
	mov al, 1 ; #setores pra serem lidos
	mov ch, 0 ; trilha 
	mov cl, 2 ; setor 2 a ser lido
	mov dh, 0 ; head 0
	mov dl, 0 ; drive 0
	int 13h
	jc lendo ;tenta de novo se detectou erro no cf
 
	jmp 0x50: 0x0 ; jmp adress 7E00h (onde esta o boot2)
	
	
times 510-($-$$) db 0
dw 0xaa55


