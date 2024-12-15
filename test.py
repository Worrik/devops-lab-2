from func_a import TrigonometricFunction


def test_func_a() -> None:
    x = 1.2
    n = 10
    expected_result = 2.57215
    result = TrigonometricFunction.func_a(x, n)
    assert abs(result - expected_result) < 0.1
