bits 32
; mach_header

_header:
    dd 0xfeedface ; magic
    dd 0x7        ; cputype -> 0x7 (CPU_TYPE_I386)
    dd 0x3        ; cpusubtype -> CPU_SUBTYPE_X86_64_ALL
    dd 0x2        ; filetype -> MH_EXECUTE
    dd 0x2        ; ncmds
    dd cmdsize    ; sizeofcmds
    dd 0x1        ; flags

cmdsize equ _load_end - _load_start

_load_start:

_load_command_2:
    dd 0x1        ; cmd -> LC_SEGMENT
    dd 0x38       ; cmdsize
    db "__TEXT"
; stuff the program inside the load command name
_program:
    xor   eax,eax
    inc   eax
    push  byte 42
    sub   esp, 4
    int   0x80

    dd 0x0        ; vmaddr
    dd 0x1000     ; vmsize
    dd 0x0        ; fileoff
    dd filesize   ; filesize
    dd 0x7        ; maxprot -> read, write, execute
    dd 0x5        ; initprot -> VM_PROT_READ(0x1) | VM_PROT_EXECUTE(0x4)
    dd 0x0        ; nsects
    dd 0x0        ; flags

_load_command_6:
    dd 0x05       ; cmd -> LC_UNIXTHREAD
    dd 0x50       ; cmdsize -> sizeof(thread_command)
    dd 0x1        ; flavour
    dd 0x10       ; count
    times 10 dd 0x0 ; zero registers
    dd _program   ; eip
    times 5 dd 0x0  ; state

_load_end:

_end:
filesize equ _end-_header
