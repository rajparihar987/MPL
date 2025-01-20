%macro io 4
	mov rax, %1
	mov rdi, %2
	mov rsi, %3
	mov rdx, %4
	syscall
%endmacro

%macro exit	0
	mov rax, 60
	mov rdi, 0
	syscall
%endmacro

Section .data
	msg1 db "Enter your Name:" ,20H
	msg1len equ $-msg1
	msg2 db "Your name is" ,20H 
	msg2len equ $-msg2
	
Section .bss
	nm resb 20
	len resb 1	
	
Section .code
	global _start
	_start:
		io 1,1,msg1,msg1len

		io 0,0,nm,20
		
		mov [len],rax
		
		io 1,1,msg2,msg2len
		
		io 1,1,nm,[len]
		
		exit

