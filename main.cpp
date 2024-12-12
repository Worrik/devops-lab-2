#include <iostream>
#include "FuncA.h"

int main() {
    TrigonometricFunction func;
    double x;
    std::cout << "Enter x: ";
    std::cin >> x;
    std::cout << func.FuncA(x) << std::endl;
    return 0;
}
