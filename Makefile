all: tiny1 tiny2 tiny3 tiny3.32

tiny1: tiny1.c
	clang -Os -o tiny1 tiny1.c
	strip tiny1

tiny2: tiny2.asm
	nasm -f macho64 -o tiny2.o tiny2.asm
	ld -static -no_uuid -e start -o tiny2 tiny2.o -macosx_version_min 10.7
	strip tiny2

tiny3: tiny3.asm
	nasm -f bin -o tiny3 tiny3.asm
	chmod +x tiny3

tiny3.32: tiny3.32.asm
	nasm -f bin -o tiny3.32 tiny3.32.asm
	chmod +x tiny3.32

clean:
	rm -f tiny1 tiny2.o tiny2 tiny3 tiny4
