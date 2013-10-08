bits 32

; mach_header
    dd 0xfeedface ; magic
    dd 0x7        ; cputype -> 0x7 (CPU_TYPE_I386)
    dd 0x3        ; cpusubtype -> CPU_SUBTYPE_I386_ALL
    dd 0x2        ; filetype -> MH_EXECUTE
    dd 0x2        ; ncmds
    dd _load_end-_load_start ; sizeofcmds
    dd 0x1        ; flags -> MH_NOUNDEFS

_load_start:

; load command 1
    dd 0x1        ; cmd -> LC_SEGMENT
    dd 0x38       ; cmdsize
    db "__TEXT"   ; segname
    times 10 db 0 ; pad to 16 bytes

    dd 0x0        ; vmaddr
    dd 0x1000     ; vmsize
    dd 0x0        ; fileoff
    dd filesize   ; filesize
    dd 0x7        ; maxprot -> read(1) | write(2) | execute(4)
    dd 0x5        ; initprot -> read(1) | execute(4)
    dd 0x0        ; nsects
    dd 0x0        ; flags

; load command 2
    dd 0x05       ; cmd -> LC_UNIXTHREAD
    dd 0x50       ; cmdsize -> sizeof(thread_command)
    dd 0x1        ; flavour
    dd 0x10       ; count
    times 10 dd 0x0 ; zero registers
    dd _program   ; eip
    times 5 dd 0x0  ; state

_load_end:

_program:
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

hw:    
    db "hello world", 0x0a
    len equ $-hw

filesize equ $-$$
