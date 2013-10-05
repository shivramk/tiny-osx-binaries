; mach_header_64

_header:
    dd 0xfeedfacf ; magic
    dd 0x01000007 ; cputype -> 0x01000000 (CPU_ARCH_ABI64) | 0x7 (CPU_TYPE_I386)
    dd 0x3        ; cpusubtype -> CPU_SUBTYPE_X86_64_ALL
	dd 0x2        ; filetype -> MH_EXECUTE
	dd 0x6        ; ncmds
	dd 0x240      ; sizeofcmds
	dd 0x1        ; flags
    dd 0x0        ; reserved

_load_start:

_load_cmd_1:
	dd 0x19       ; cmd -> LC_SEGMENT_64
	dd 0x48       ; cmdsize -> sizeof(segment_command_64)
    db "__PAGEZERO",0,0,0,0,0,0 ; segname -> __PAGEZERO
    dq 0x0        ; vmaddr
    dq 0x1000     ; vmsize
    dq 0x0        ; fileoff
    dq 0x0        ; filesize
    dd 0x0        ; maxprot
    dd 0x0        ; initprot
    dd 0x0        ; nsects
    dd 0x0        ; flags

_load_command_2:
	dd 0x19       ; cmd -> LC_SEGMENT_64
	dd 0x98       ; cmdsize
    db "__TEXT",0,0,0,0,0,0,0,0,0,0 ; segname -> __TEXT
	dq 0x1000     ; vmaddr
	dq 0x1000     ; vmsize
    dq 0x0        ; fileoff
	dq 0x1000     ; filesize
	dd 0x7        ; maxprot -> read, write, execute
	dd 0x5        ; initprot -> VM_PROT_READ(0x1) | VM_PROT_EXECUTE(0x4)
	dd 0x1        ; nsects
    dd 0x0        ; flags

_section_1:
    db "__text",0,0,0,0,0,0,0,0,0,0 ; sectname -> __text
    db "__TEXT",0,0,0,0,0,0,0,0,0,0 ; segname -> __TEXT
    dq 0x1fd1       ; addr
	dq 0x2f         ; size
    dd 0x0fd1       ; offset
    dd 0x0          ; align
    dd 0x0          ; reloff
    dd 0x0          ; nreloc
    dd 0x80000400   ; flags
	dd 0x0          ; reserved1
	dd 0x0          ; reserved2
	dd 0x0          ; reserved3

_load_command_3:
	dd 0x19       ; cmd -> LC_SEGMENT_64
	dd 0x48       ; cmdsize -> sizeof(segment_command_64)
    db "__DATA",0,0,0,0,0,0,0,0,0,0 ; segname -> __DATA
    dq 0x2000     ; vmaddr
    dq 0x0        ; vmsize
	dq 0x1000     ; fileoff
	dq 0x0        ; filesize
	dd 0x7        ; maxprot -> read, write, execute
	dd 0x3        ; initprot -> VM_PROT_READ(0x1) | VM_PROT_WRITE(0x2)
	dd 0x0        ; nsects
    dd 0x0        ; flags

_load_command_4:
	dd 0x19       ; cmd -> LC_SEGMENT_64
	dd 0x48       ; cmdsize -> sizeof(segment_command_64)
    db "__LINKEDIT",0,0,0,0,0,0 ; segname -> __LINKEDIT
    dq 0x2000     ; vmaddr
    dq 0x0        ; vmsize
	dq 0x1000     ; fileoff
	dq 0x0        ; filesize
	dd 0x7        ; maxprot -> read, write, execute
	dd 0x1        ; initprot -> VM_PROT_READ(0x1)
	dd 0x0        ; nsects
    dd 0x0        ; flags

_load_command_5:
	dd 0x02       ; cmd -> LC_SYMTAB
	dd 0x18       ; cmdsize -> sizeof(symtab_command)
    dd 0x0        ; symoff
    dd 0x0        ; nsyms
    dd 0x0        ; stroff
    dd 0x0        ; strsize

_load_command_6:
	dd 0x05       ; cmd -> LC_UNIXTHREAD
	dd 0xb8       ; cmdsize -> sizeof(thread_command)
	dd 0x4        ; flavour
	dd 0x2a       ; count
	times 128 db 0x0 ; zero all general purpose registers
	db 0xd1
	db 0x1f
	times 3479 db 0x0

bits 64
_program:
    mov rdi, 1
    mov rsi, hw+0x1000 ; program is loaded at 0x1000
    mov rdx, len
    mov eax, 0x2000004
    syscall

    mov eax, 0x2000001
    syscall
    ret
hw:
    db "hello world", 0xa
len equ $-hw
