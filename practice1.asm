%macro io 4
	mov rax, %1
	mov rdi, %2
	mov rsi, %3
	mov rdx, %4
	syscall
%endmacro

section .bss
	num resq 17
	
	
section .code 
	global _start
	_start:
		io 0,0, num,17
		call ascii_hex64
		mov rax,60
		mov rdi, 0
		syscall
		
	ascii_hex64:
		mov rsi,num
		mov rbx,0
		mov rcx,16
	next:
		rol rbx,16
		mov al,[rsi]
		cmp al,39h
		jbe sub_30h
		sub al ,7h
	sub_30h:
		sub al,30h
		add bl,al
		inc rsi
		loop next
		ret
	
