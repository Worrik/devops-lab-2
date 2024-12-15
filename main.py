from func_a import TrigonometricFunction


def main() -> None:
    x_str = input("Enter x: ")
    n_str = input("Enter n: ")
    x = float(x_str)
    n = int(n_str)
    result = TrigonometricFunction.func_a(x, n)
    print(f"func_a({x}, {n}) = {result}")


if __name__ == "__main__":
    main()
