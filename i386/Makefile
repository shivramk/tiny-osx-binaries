all: tiny1 tiny2 tiny3 tiny4 dyld tiny5

tiny1: tiny1.c
	clang -Os -o tiny1 tiny1.c
	strip tiny1

tiny2: tiny2.asm
	nasm -f macho32 -o tiny2.o tiny2.asm
	ld -static -no_uuid -e start -o tiny2 tiny2.o -macosx_version_min 10.7
	strip tiny2

tiny3: tiny3.asm
	nasm -f bin -o tiny3 tiny3.asm
	chmod +x tiny3

tiny4: tiny4.asm
	nasm -f bin -o tiny4 tiny4.asm
	chmod +x tiny4

dyld: dyld.asm
	nasm -f macho -o dyld.o dyld.asm
	ld -dylinker -seg1addr 0x8fe00000 -e __dyld_start -o dyld dyld.o -macosx_version_min 10.7

tiny5: tiny5.asm
	nasm -f bin -o tiny5 tiny5.asm
	chmod +x tiny5

clean:
	rm -f *.o tiny1 tiny2 tiny3 tiny4 tiny5 dyld
