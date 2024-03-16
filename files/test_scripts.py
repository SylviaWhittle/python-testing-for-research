"""Tests for the scripts python file"""

from scripts import add



def test_add():
    assert add(1, 2) == 3
    assert add(5, 0) == 5
    assert add(0, 0) == 0
    assert add(-1, 1) == 0
    assert add(-1, -1) == -2
    assert add(-5, -5) == -10
