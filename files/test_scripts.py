"""Tests for the scripts python file"""

from scripts import add, broken_check_if_prime


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
