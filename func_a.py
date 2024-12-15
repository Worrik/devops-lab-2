import math

BERNOULLI_N2 = [
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
    854513.0 / 138.0,
]


class TrigonometricFunction:
    @staticmethod
    def _factorial(n: int) -> int:
        if n < 1:
            return 1
        return math.prod(range(1, n + 1))

    @staticmethod
    def func_a(x: float, n: int) -> float:
        return sum(
            BERNOULLI_N2[i - 1]
            * ((-4) ** i)
            * (1 - 4**i)
            * x ** (2 * i - 1)
            / TrigonometricFunction._factorial(2 * i)
            for i in range(1, n + 1)
        )
