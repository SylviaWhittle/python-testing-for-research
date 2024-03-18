"""Tests for the scripts python file"""

from scripts import add, broken_check_if_prime

import pytest


def test_add():
    assert add(1, 2) == 3
    assert add(5, 0) == 5
    assert add(0, 0) == 0
    assert add(-1, 1) == 0
    assert add(-1, -1) == -2
    assert add(-5, -5) == -10


def test_broken_check_if_prime():
    assert broken_check_if_prime(0) == False
    assert broken_check_if_prime(1) == False
    assert broken_check_if_prime(2) == True
    assert broken_check_if_prime(3) == True
    assert broken_check_if_prime(4) == False
    assert broken_check_if_prime(5) == True
    assert broken_check_if_prime(6) == False
    assert broken_check_if_prime(7) == True


# Parameterization
pytest.mark.parametrize(
    "n, expected", [(0, False), (1, False), (2, True), (3, True), (4, False), (5, True), (6, False), (7, True)]
)


def test_check_if_prime(n, expected):
    assert broken_check_if_prime(n) == expected
