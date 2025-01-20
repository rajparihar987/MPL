%macro io 4
	mov rax, %1
	mov rdi, %2
	mov rsi, %3
	mov rdx, %4
	syscall
%endmacro

section .data
	msg1 db "Write an X86/64 ALP to accept five hexadecimal numbers from user and store them in an array and display the accepeted numbers." ,10
	len1 equ $-msg1
	msg2 db "Enter five 64-bits hexadecimal numbers" ,10
	len2 equ $-msg2
	msg3 db "Five 64 bits hexadecimal numbers are as follows:- ",10
	len3 equ $-msg3
	newline db 10

section .bss
	ascii_num resb 17
	hexnum resq 5

section .code
global _start
	_start:
		io 1,1,msg1,len1
		io 1,1,msg2,len2
		mov rcx,5
		mov rsi,hexnum
		next1:
			push rsi
			push rcx
			io 0,0,ascii_num,17
			call ascii_hex64
			pop rcx 
			pop rsi
			mov [rsi],rbx
			add rsi,8
		loop next1
		
		io 1,1,msg3,len3
		mov rsi,hexnum
		mov rcx,5
		
		next2: 
			push rsi
			push rcx
			mov rbx,[rsi]
			call hex_ascii64
			pop rcx 
			pop rsi
			add rsi,8
		loop next2
	mov rax,60
	mov rdi,0
	syscall

ascii_hex64:
	mov rsi,ascii_num
	
	mov rbx,0
	mov rcx,16
	
	next3:
		rol rbx,4
		mov al,[rsi]
		cmp al,39H
		jbe sub30h
		sub al,7H
		
		sub30h:
			sub al,30H
			add bl,al
			inc rsi
	loop next3
	ret

hex_ascii64:
	mov rsi,ascii_num
	mov rcx,16
	
	next4:	
		rol rbx,4
		mov al,bl
		and al,0fh
		cmp al,9
		jbe add30h
		add al,7H
		
		add30h:
			add al,30H
			mov[rsi],al
			inc rsi
	loop next4
	io 1,1,ascii_num,16
	io 1,1,newline,1
	ret
			
	
