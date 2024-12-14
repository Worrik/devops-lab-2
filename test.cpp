#include <iostream>
#include <cmath>
#include "FuncA.h"

bool testFuncA() {
    TrigonometricFunction func;

    double result = func.FuncA(1.0, 1);
    double expected = 1;
    if (std::abs(result - expected) > 0.01) {
        std::cerr << "Test case 1 failed: expected " << expected << ", got " << result << std::endl;
        return false;
    }

    return true; // All tests passed
}

int main() {
    if (testFuncA()) {
        std::cout << "All tests passed!" << std::endl;
        return 0;
    } else {
        std::cout << "Some tests failed." << std::endl;
        return 1;
    }
}
