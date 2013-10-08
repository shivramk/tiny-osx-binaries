## Creating a Mach-O binary from scratch


### Some interesting pointers

```bsd/kern/syscalls.master``` is where syscall numbers are defined in the kernel

The userspace code which makes syscalls is in ```/usr/lib/system/libsystem_kernel.dylib```

Sample code for _write:

```
_write:
00000000000134a0        movl    $0x2000004, %eax
00000000000134a5        movq    %rcx, %r10
00000000000134a8        syscall
00000000000134aa        jae     0x134b1
00000000000134ac        jmpq    0x134c8
00000000000134b1        ret
00000000000134b2        nop
00000000000134b3        nop
```
