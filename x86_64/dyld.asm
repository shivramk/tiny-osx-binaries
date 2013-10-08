section .text
hw:    db "hello world", 0x0a
len:   equ $-hw

global __dyld_start
__dyld_start:
    mov rdi, 1
    mov rsi, hw
    mov rdx, len
    mov eax, 0x2000004
    syscall
    jmp next
next:
    mov eax, 0x2000001
    syscall

