"""Test for the add function"""

from calculator import add, multiply


# Test add with if statements
# def test_add():
#     """Test for the add function"""
#     if add(1, 2) != 3:
#         raise AssertionError("1 + 2 != 3")
#     if add(-1, -2) != -3:
#         raise AssertionError("-1 + -2 != -3")
#     if add(0, 4) != 4:
#         raise AssertionError("0 + 4 != 4")


# Test add with assert
def test_add():
    """Test for the add function"""
    # Check that positive numbers work
    assert add(1, 2) == 3
    # Check that negative numbers work
    assert add(-1, -2) == -3
    # Check that adding 0 works
    assert add(0, 4) == 4


def test_multiply():
    """Test for the multiply function"""
    # Check that positive numbers work
    assert multiply(5, 5) == 25
    # Check that multiplying by 1 works
    assert multiply(1, 5) == 5
    # Check that multiplying by 0 works
    assert multiply(0, 3) == 0
    # Check that negative numbers work
    assert multiply(-5, 2) == -10
