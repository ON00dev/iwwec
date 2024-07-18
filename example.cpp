#include <iostream>

class Example {
public:
    int add(int a, int b) {
        return a + b;
    }
};

int main() {
    Example ex;
    int x = 5;
    int y = 10;
    int z = ex.add(x, y);
    std::cout << "Sum: " << z << std::endl;
    return 0;
}
