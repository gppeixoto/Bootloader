org 0x7e00
jmp 0x0000:start

precious db "  ____                         _                    ___    ____  ", 13, 10, " |  _ \   _ __    ___    ___  (_)   ___    _   _   / _ \  / ___| ", 13, 10, " | |_) | | '__|  / _ \  / __| | |  / _ \  | | | | | | | | \___ \ ", 13, 10, " |  __/  | |    |  __/ | (__  | | | (_) | | |_| | | |_| |  ___) |", 13, 10, " |_|     |_|     \___|  \___| |_|  \___/   \__,_|  \___/  |____/ ", 13, 10, "                                                                 ", 13, 10, "                     My Precious Operational System", 13, 10, 0

gollum db "                           `-.", 13, 10, "              -._ `. `-.`-. `-.", 13, 10, "             _._ `-._`.   .--.  `.", 13, 10, "          .-'   '-.  `-|\/    \|   `-.", 13, 10, "        .'         '-._\   (o)O) `-.", 13, 10, "       /         /         _.--.\ '. `-. `-.", 13, 10, "      /|    (    |  /  -. ( -._( -._ '. '.", 13, 10, "     /  \    \-.__\ \_.-'`.`.__'.   `-, '. .'", 13, 10, "     |  /\    |  / \ \     `--')/  .-'.'.'", 13, 10, " .._/  /  /  /  / / \ \          .' . .' .'", 13, 10, "/  ___/  |  /   \ \  \ \__       '.'. . .", 13, 10, "\  \___  \ (     \ \  `._ `.     .' . ' .'", 13, 10, " \ `-._\ (  `-.__ | \    )//   .'  .' .-'", 13, 10, "  \_-._\  \  `-._\)//    ''''_.-' .-' .' .'", 13, 10, "    `-'    \ -._\ ''''_..--''  .-' .'", 13, 10, "            \/    .' .-'.-'  .-' .-'", 13, 10, "                .-'.' .'  .' .-'", 13, 10, 0

ring db "",13, 10, "",13, 10, "", 13, 10, "", 13, 10,"",13, 10, "",13, 10, "", 13, 10, "", 13, 10,"",13, 10, "",13, 10, "", 13, 10, "", 13, 10,"",13, 10, "",13, 10, "", 13, 10, "", 13, 10,"",13, 10, "",13, 10, "", 13, 10, "", 13, 10,"",13, 10, "",13, 10, "", 13, 10, "", 13, 10, "                     .--------------------------------+", 13, 10, "                     : One OS to rule them all,       |", 13, 10, "                     : One OS to find them,           |", 13, 10, "                     : One OS to bring them all,      |", 13, 10, "                     : and in the darkness BOOT them. |", 13, 10, "                     '--------------------------------+", 13, 10, 0


gandalf db "                           ,---.", 13, 10, "                          /    |", 13, 10, "                         /     |", 13, 10, "     Gandalf            /      |", 13, 10, "                       /       |", 13, 10, "                  ___,'        |", 13, 10, "                <  -'          :", 13, 10, "                 `-.__..--'``-,_\_", 13, 10, "                    |o/ <o>` :,.)_`>", 13, 10, "                    :/ `     ||/)", 13, 10, "                    (_.).__,-` |\", 13, 10, "                    /( `.``   `| :", 13, 10, "                    \'`-.)  `  ; ;", 13, 10, "                    | `       /-<", 13, 10, "                    |     `  /   `.", 13, 10, "    ,-_-..____     /|  `    :__..-'\", 13, 10, "   /,'-.__\\  ``-./ :`      ;       \", 13, 10, "   `\ `\  `\\  \ :  (   `  /  ,   `. \", 13, 10, "     \` \   \\   |  | `   :  :     .\ \", 13, 10, "      \ `\_  ))  :  ;     |  |      ): :", 13, 10, "     (`-.-'\ ||  |\ \   ` ;  ;       | |", 13, 10, "      \-_   `;;._   ( `  /  /_       | |", 13, 10, "       `-.-.// ,'`-._\__/_,'         ; |", 13, 10, "          \:: :     /     `     ,   /  |", 13, 10, "           || |    (        ,' /   /   |", 13, 10, "           ||                ,'   / SSt|", 13, 10, 0

initialize db " +-+-+-+ +-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+ ", 13, 10, " |Y|O|U| |S|H|A|L|L| |I|N|I|T|I|A|L|I|Z|E|!| ", 13, 10, " +-+-+-+ +-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+ ", 13, 10, 0

start:

	xor ax, ax ; zerando o ds pq eh a partir dele q o processador busca os dados utilizados no prog
	mov ds, ax 

	xor cx, cx ; limpando
	xor si, si ; limpando
	xor bx, bx ; limpando
	xor dx, dx ; limpando
	
	mov ah, 0
	mov al, 12h		;vga 640x480
	int 10h			;interrupcao de set video mode
	mov bl, 70
	
	;parte do codigo que faz os prints do kernel. O procedimento é: limpa si, carrega string em si,
		;pula uma linha, printa (e ocasionalmente, haverá uma pausa de vídeo). procedimento repetido
			;para todas as strings do kernel
			
	xor si, si			
	mov si, precious	
	call barran			
	call print			
	xor si, si			
	mov si, gollum		
	call barran		
	call print			
	call pausa			
	xor si, si
	mov si, ring
	call barran
	call print
	call pausa
	xor si, si
	mov si, gandalf
	call barran
	call print
	xor si, si
	mov si, initialize
	call print

jmp $

print:				;si=endereço inicial, lodsb--> al=[si]; si++
	lodsb 			;carrega si em al
	cmp al, 0		;achou o fim, encerra o print
	je acabou	
	mov ah,	0eh
	int 10h			;interrupcao de print
	jmp print
	
acabou:
ret

barran:				;metodo pra pular linha
	mov al, 10 		;dá o \n, char 10
	mov ah, 0Eh
	int 10h
	
	mov al, 13		;traz o cursor pro canto esquerdo da linha, char 13 do carriage ret
	mov ah, 0Eh
	int 10h
ret

pausa:				;pausa o vídeo por (cx milissegundos) + (dx microssegundos)
	mov ah, 86h		;interrupcao de wait
	mov cx, 75		;tempo cx em milissegundos, dx em microssegundos
	mov dx, 0		;obs: tempo varia de acordo com a máquina e com quantos processos estão abertos, não
	int 15h				;é exatamente "determinístico"
ret
	
