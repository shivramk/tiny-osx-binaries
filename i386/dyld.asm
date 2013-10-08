section .text

global __dyld_start
__dyld_start:
    ; dyld needs to have position independent code
    ; the following code puts the address of hello world in ebx
    call _next
_next:
    pop ebx
    offset equ hw-_next
    add ebx, offset

    xor eax, eax
    mov al, 4
    push byte len
    push ebx
    push byte 1
    sub esp, 4
    int 0x80

    xor eax, eax
    inc eax
    push byte 0
    int 0x80

hw:
    db 'hello world', 0xa
    len equ $-hw
