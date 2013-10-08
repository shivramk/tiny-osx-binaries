section .text
global start
start:
    xor eax, eax
    mov al, 4
    push byte len
    push dword hw
    push byte 1
    sub esp, 4
    int 0x80

    xor eax, eax
    inc eax
    push byte 0
    int 0x80

hw:    db "hello world", 0x0a
len:   equ $-hw
