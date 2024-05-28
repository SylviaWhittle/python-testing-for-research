---
title: 'Testing for Exceptions'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How check that a function raises an exception?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Learn how to test exceptions using `pytest.raises`.

::::::::::::::::::::::::::::::::::::::::::::::::

## What to do about code that raises exceptions?

Sometimes you will want to make sure that a function raises an exception when it should. For example, you might want to check that a function raises a `ValueError` when it receives an invalid input.

Take this example of the `square_root` function. We don't have time to implement complex numbers yet, so we can raise a `ValueError` when the input is negative to crash a program that tries to compute the square root of a negative number.

```python

def square_root(x):
   if x < 0:
      raise ValueError("Cannot compute square root of negative number yet!")
   return x ** 0.5

```

We can test that the function raises an exception using `pytest.raises` as follows:

```python
import pytest

from advanced.advanced_calculator import square_root

def test_square_root():
    with pytest.raises(ValueError):
        square_root(-1)
```

Here, `pytest.raises` is a context manager that checks that the code inside the `with` block raises a `ValueError` exception. If it doesn't, the test fails.

If you want to get more detailled with things, you can test what the error message says too:
```python

def test_square_root():
    with pytest.raises(ValueError) as e:
        square_root(-1)
    assert str(e.value) == "Cannot compute square root of negative number yet!"

```

::::::::::::::::::::::::::::::::::::: challenge 

## Challenge : Ensure that the divide function raises a ZeroDivisionError when the denominator is zero.

- Add a divide function to `calculator.py`:

```python

def divide(numerator, denominator):
    if denominator == 0:
        raise ZeroDivisionError("Cannot divide by zero!")
    return numerator / denominator
```

- Write a test in `test_calculator.py` that checks that the divide function raises a `ZeroDivisionError` when the denominator is zero.

:::::::::::::::::::::::: solution 

```python
import pytest

from calculator import divide

def test_divide():
    with pytest.raises(ZeroDivisionError):
        divide(1, 0)
```
:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::: keypoints 

- Use `pytest.raises` to check that a function raises an exception.

::::::::::::::::::::::::::::::::::::::::::::::::

