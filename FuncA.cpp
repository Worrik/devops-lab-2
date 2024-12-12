#include "FuncA.h"
#include <cmath>

const double Bernoulli_n2[] = {
    1.0 / 6.0,
    -1.0 / 30.0,
    1.0 / 42.0,
    -1.0 / 30.0,
    5.0 / 66.0,
    -691.0 / 2730.0,
    7.0 / 6.0,
    -3617.0 / 510.0,
    43867.0 / 798.0,
    -174611.0 / 330.0,
    854513.0 / 138.0
};

int factorial(int n) {
    if (n == 0) {
        return 1;
    }
    return n * factorial(n - 1);
}

double TrigonometricFunction::FuncA(double x) {
    double sum = 0.0;
    for (int i = 1; i <= 3; i++) {
        sum += Bernoulli_n2[i - 1] * pow(4, i) * (pow(4, i) - 1) * pow(x, 2 * i - 1) / factorial(2 * i);
    }
    return sum;
}
