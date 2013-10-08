section .text
global start
start:
    mov rdi, 1
    mov rsi, hw
    mov rdx, len
    mov eax, 0x2000004
    syscall

    mov eax, 0x2000001
    syscall

hw:    
    db "hello world", 0x0a
    len equ $-hw
