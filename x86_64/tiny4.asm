bits 64

; mach_header_64
    dd 0xfeedfacf ; magic
    dd 0x01000007 ; cputype -> 0x01000000 (CPU_ARCH_ABI64) | 0x7 (CPU_TYPE_I386)
    dd 0x3        ; cpusubtype -> CPU_SUBTYPE_X86_64_ALL
	dd 0x2        ; filetype -> MH_EXECUTE
	dd 0x2        ; ncmds
	dd _load_end-_load_start ; sizeofcmds
	dd 0x1        ; flags
    dd 0x0        ; reserved

_load_start:

; load command 1
	dd 0x19       ; cmd -> LC_SEGMENT_64
	dd 0x48       ; cmdsize
    db "__TEXT",0,0,0,0,0,0,0,0,0,0 ; segname -> __TEXT
	dq 0x         ; vmaddr
	dq 0x1000     ; vmsize
    dq 0x0        ; fileoff
	dq filesize   ; filesize
	dd 0x7        ; maxprot -> read, write, execute
	dd 0x5        ; initprot -> VM_PROT_READ(0x1) | VM_PROT_EXECUTE(0x4)
	dd 0x0        ; nsects
    dd 0x0        ; flags

; load command 2
	dd 0x05       ; cmd -> LC_UNIXTHREAD
	dd 0xb8       ; cmdsize -> sizeof(thread_command)
	dd 0x4        ; flavour
	dd 0x2a       ; count
; stuff the program inside the initial register values
_program:
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

    times 128-($-_program) db 0 ; pad to 128 bytes
    dq _program ; rip
    times 4 dq 0x0    ; zero rflags, cs, fs, gs

_load_end:

filesize equ $-$$
