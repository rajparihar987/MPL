; Write an X86/64 ALP to accept a string and to display its length.

; Date : 27 January 2025
; Name : Raj Parihar  Roll no: 7243

; Macro defined for input and output
%macro io 4
	mov rax, %1  ; Assigning System Call Number to rax (1 for syswrite and 0 for sys read)
	mov rdi, %2  ; Assigning File Descriptor to rdi (1 for stdout and 0 for sys stdin)
	mov rsi, %3  ; Assigning rsi the address of buffer to print/input
	mov rdx, %4  ; Assigning length of the buffer to rdx register
	syscall      ; System Call --> Generates interrupt to Kernel
%endmacro

; Macro defined for exit the program
%macro exit 0
    mov rax,60   ; Assigning System Call number to rax (60 for sys_exit)
	mov rdi,0    ; Setting exit status to 0
	syscall      ; Generate interrupt to Kernel (this exits the program)
%endmacro

section .data
    msg1 db 10,13,"Please enter the String of which length u want to find"  ; Message to prompt user input
    len1 equ $-msg1                  ; Length of the message

section .bss
    str1 resb 200    ; Reserve 200 bytes for storing input string
    result resb 16   ; Reserve 16 bytes for storing processed result

section .text
    global _start

_start:
    ; Display the prompt message
    io 1,1,msg1,len1

    ; Read the input string from user
    io 0,0,str1,200

    call display      ; Call the display function

    ; Exit system call
    exit

display:
    mov rbx, rax      ; Store input length in rbx
    mov rdi, result   ; Point rdi to result variable
    mov cx, 16        ; Loop counter: process 16 characters

up1:
    rol rbx, 4        ; Rotate rbx left by 4 bits
    mov al, bl        ; Move lower byte of rbx into al
    and al, 0fh       ; Mask to keep only the lowest 4 bits
    cmp al, 9         ; Compare with decimal 9
    jg add_37         ; If greater than 9, jump to add_37
    add al, 30h       ; Convert 0-9 to ASCII '0'-'9'
    jmp skip          ; Skip next instruction
add_37:
    add al, 37h       ; Convert A-F to ASCII 'A'-'F'
skip:
    mov [rdi], al     ; Store ASCII character in result variable
    inc rdi           ; Move to the next byte in result
    dec cx            ; Decrease loop counter
    jnz up1           ; If not zero, repeat loop

    io 1,1,result,16  ; Call macro to display result

    ret               ; Return from function
