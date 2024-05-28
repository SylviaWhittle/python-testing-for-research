from advanced_calculator import power, is_prime
import pytest


def test_power():
    """Test for the power function"""
    assert power(2, 3) == 8
    assert power(3, 3) == 27


@pytest.mark.parametrize(
    ("n, expected"),
    [
        pytest.param(0, False, id="0 is not prime"),
        pytest.param(1, False, id="1 is not prime"),
        pytest.param(2, True, id="2 is prime"),
        pytest.param(3, True, id="3 is prime"),
        pytest.param(4, False, id="4 is not prime"),
        pytest.param(5, True, id="5 is prime"),
        pytest.param(6, False, id="6 is not prime"),
        pytest.param(7, True, id="7 is prime"),
        pytest.param(8, False, id="8 is not prime"),
        pytest.param(9, False, id="9 is not prime"),
        pytest.param(10, False, id="10 is not prime"),
        pytest.param(11, True, id="11 is prime"),
        pytest.param(12, False, id="12 is not prime"),
        pytest.param(13, True, id="13 is prime"),
        pytest.param(14, False, id="14 is not prime"),
        pytest.param(15, False, id="15 is not prime"),
        pytest.param(16, False, id="16 is not prime"),
        pytest.param(17, True, id="17 is prime"),
        pytest.param(18, False, id="18 is not prime"),
        pytest.param(19, True, id="19 is prime"),
        pytest.param(20, False, id="20 is not prime"),
        pytest.param(21, False, id="21 is not prime"),
        pytest.param(22, False, id="22 is not prime"),
        pytest.param(23, True, id="23 is prime"),
        pytest.param(24, False, id="24 is not prime"),
    ],
)
def test_is_prime(n, expected):
    assert is_prime(n) == expected
