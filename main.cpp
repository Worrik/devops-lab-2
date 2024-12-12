#include <iostream>
#include "FuncA.h"

int main() {
    TrigonometricFunction func;
    double x;
    int n;
    std::cout << "Enter x: ";
    std::cin >> x;
    std::cout << "Enter n: ";
    std::cin >> n;
    std::cout << "FuncA(" << x << ", " << n << ") = " << func.FuncA(x, n) << std::endl;
    return 0;
}
