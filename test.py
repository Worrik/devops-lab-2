from fastapi.testclient import TestClient
from func_a import TrigonometricFunction
from http_server import app

import pytest


def test_func_a() -> None:
    x = 1.2
    n = 10
    expected_result = 2.57215
    result = sum(TrigonometricFunction.func_a(x, n))
    assert abs(result - expected_result) < 0.1


@pytest.mark.parametrize("x, n", [(1.0, 10), (0.5, 5)])
def test_calculate_response(x, n):
    client = TestClient(app)
    response = client.get("/", params={"x": x, "n": n})

    assert response.status_code == 200, "Response status code should be 200"

    data = response.json()

    assert isinstance(
        data["elapsed_time_seconds"], float
    ), "'elapsed_time_seconds' should be a float"

    assert (
        5 < data["elapsed_time_seconds"] < 20
    ), "Elapsed time should be within 5 to 20 seconds"
