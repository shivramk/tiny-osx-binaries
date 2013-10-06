bits 64
; mach_header_64

_header:
    dd 0xfeedfacf ; magic
    dd 0x01000007 ; cputype -> 0x01000000 (CPU_ARCH_ABI64) | 0x7 (CPU_TYPE_I386)
    dd 0x3        ; cpusubtype -> CPU_SUBTYPE_X86_64_ALL
	dd 0x2        ; filetype -> MH_EXECUTE
	dd 0x2        ; ncmds
	dd cmdsize    ; sizeofcmds
	dd 0x1        ; flags
    dd 0x0        ; reserved

cmdsize equ _load_end - _load_start

_load_start:

_load_command_2:
	dd 0x19       ; cmd -> LC_SEGMENT_64
	dd 0x48       ; cmdsize
    db "__TEXT",0,0,0,0,0,0,0,0,0,0 ; segname -> __TEXT
	dq 0x1000     ; vmaddr
	dq 0x1000     ; vmsize
    dq 0x0        ; fileoff
	dq filesize   ; filesize
	dd 0x7        ; maxprot -> read, write, execute
	dd 0x5        ; initprot -> VM_PROT_READ(0x1) | VM_PROT_EXECUTE(0x4)
	dd 0x0        ; nsects
    dd 0x0        ; flags

_load_command_6:
	dd 0x05       ; cmd -> LC_UNIXTHREAD
	dd 0xb8       ; cmdsize -> sizeof(thread_command)
	dd 0x4        ; flavour
	dd 0x2a       ; count
times 16 dq 0x0   ; zero all general purpose registers r0 to r15
    dq _program+0x1000 ; rip
times 4 dq 0x0    ; zero rflags, cs, fs, gs

_load_end:

_program:
    mov rdi, 42
    mov eax, 0x2000001 ; exit
    syscall
_end:

proglen equ _end-_program
filesize equ _end-_header
