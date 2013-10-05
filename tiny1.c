#include <unistd.h>

int main() {
    write(1, "hello world\n", 12);
    return 0;
}
