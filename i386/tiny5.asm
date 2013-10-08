bits 32
; mach_header

_header:
    dd 0xfeedface ; magic
    dd 0x7        ; cputype -> 0x7 (CPU_TYPE_I386)
    dd 0x3        ; cpusubtype -> CPU_SUBTYPE_X86_64_ALL
    dd 0x2        ; filetype -> MH_EXECUTE
    dd 0x2        ; ncmds
    dd _load_end - _load_start ; sizeofcmds
    dd 0x5        ; flags -> MH_NOUNDEFS(1) | MH_DYLDLINK(4)

_load_start:

; load command 1
    dd 0x80000028 ; cmd -> LC_MAIN
    dd 0x18       ; cmdsize
    dq 0          ; entryoff (doesn't matter)
    dq 0          ; stacksize (doesn't matter)

; load command 2
    dd 0xe        ; cmd -> LC_LOAD_DYLINKER
    dd 0x10       ; cmdsize
    dd 0xc        ; offset
    db '/ld', 0   ; align to 4 bytes

_load_end:
