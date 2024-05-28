---
title: 'Parametrization'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- Is there a better way to test a function with lots of different inputs than writing a separate test for each one?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Understand how to use parametrization in pytest to run the same test with different parameters in a concise and more readable way.

::::::::::::::::::::::::::::::::::::::::::::::::


## Parametrization

When writing tests for functions that need to test lots of different combinations of inputs, this can take a lot of
space and be quite verbose. Parametrization is a way to run the same test with different parameters in a concise and more readable way.

To use parametrization in pytest, you need to use the `@pytest.mark.parametrize` decorator (don't worry if you don't know what this means).
This decorator takes two arguments: the name of the parameters and the list of values you want to test.

Consider the following example:

We have a Triangle class that has a function to calculate the triangle's area from its side lengths.

```python

def Point:
   def __init__(self, x, y):
       self.x = x
       self.y = y

class Triangle:
   def __init__(self, p1: Point, p2: Point, p3: Point):
      self.p1 = p1
      self.p2 = p2
      self.p3 = p3

   def calculate_area(self):
      a = ((self.p1.x * (self.p2.y - self.p3.y)) +
           (self.p2.x * (self.p3.y - self.p1.y)) +
           (self.p3.x * (self.p1.y - self.p2.y))) / 2
      return abs(a)

```

If we want to test this function with different combinations of sides, we could write a test like this:

```python
def test_calculate_area():
   """Test the calculate_area function of the Triangle class"""

   # Equilateral triangle
   p11 = Point(0, 0)
   p12 = Point(2, 0)
   p13 = Point(1, 1.7320)
   t1 = Triangle(p11, p12, p13)
   assert t1.calculate_area() == 6

   # Right-angled triangle
   p21 = Point(0, 0)
   p22 = Point(3, 0)
   p23 = Point(0, 4)
   t2 = Triangle(p21, p22, p23)
   assert t2.calculate_area() == 6

   # Isosceles triangle
   p31 = Point(0, 0)
   p32 = Point(4, 0)
   p33 = Point(2, 8)
   t3 = Triangle(p31, p32, p33)
   assert t3.calculate_area() == 16

   # Scalene triangle
   p41 = Point(0, 0)
   p42 = Point(3, 0)
   p43 = Point(1, 4)
   t4 = Triangle(p41, p42, p43)
   assert t4.calculate_area() == 6

   # Negative values
   p51 = Point(0, 0)
   p52 = Point(-3, 0)
   p53 = Point(0, -4)
   t5 = Triangle(p51, p52, p53)
   assert t5.calculate_area() == 6
```

This test is quite long and repetitive. We can use parametrization to make it more concise:

```python
import pytest

@pytest.mark.parametrize(
   ("p1x, p1y, p2x, p2y, p3x, p3y, expected"),
   [
      pytest.param(0, 0, 2, 0, 1, 1.7320, 6, id="Equilateral triangle"),
      pytest.param(0, 0, 3, 0, 0, 4, 6, id="Right-angled triangle"),
      pytest.param(0, 0, 4, 0, 2, 8, 16, id="Isosceles triangle"),
      pytest.param(0, 0, 3, 0, 1, 4, 6, id="Scalene triangle"),
      pytest.param(0, 0, -3, 0, 0, -4, 6, id="Negative values")
   ]
)
def test_calculate_area(p1x, p1y, p2x, p2y, p3x, p3y, expected):
   p1 = Point(p1x, p1y)
   p2 = Point(p2x, p2y)
   p3 = Point(p3x, p3y)
   t = Triangle(p1, p2, p3)
   assert t.calculate_area() == expected
```

Let's have a look at how this works.

Similar to how fixtures are defined, the `@pytest.mark.parametrize` line is a decorator, letting pytest know that this is a parametrized test.

- The first argument is a tuple, a list of the names of the parameters you want to use in your test. For example
`("p1x, p2y, p2x, p2y, p3x, p3y, expected")` means that we will use the parameters `p1x`, `p1y`, `p2x`, `p2y`, `p3x`, `p3y` and `expected` in our test.

- The second argument is a list of `pytest.param` objects. Each `pytest.param` object is a tuple of the values you want to test, with an optional `id` argument to give a name to the test.
For example, `pytest.param(0, 0, 2, 0, 1, 1.7320, 6, id="Equilateral triangle")` means that we will test the function with the parameters `0, 0, 2, 0, 1, 1.7320, 6` and give it the name "Equilateral triangle".

(note that if the test fails you will see the id in the output, so it's useful to give them meaningful names to help you understand what went wrong.)

- The test function will be run once for each set of parameters in the list.

- Inside the test function, you can use the parameters as you would any other variable.

This is a much more concise way to write tests for functions that need to be tested with lots of different inputs, especially when there is a lot of repetition in the setup for each of the different test cases.

::::::::::::::::::::::::::::::::::::: challenge 

## Challenge - Practice with Parametrization

Add the following function to `advanced/advanced_calculator.py` and write a parametrized test for it in `tests/test_advanced_calculator.py` that tests the function with a range of different inputs
using parametrization.

```python

def is_prime(n: int) -> bool:
    """Return True if n is a prime number, False otherwise"""
    if n < 2:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True

```

:::::::::::::::::::::::: solution 

```python
import pytest

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
   ]
)
def test_is_prime(n, expected):
   assert is_prime(n) == expected
```

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::: keypoints 

- Parametrization is a way to run the same test with different parameters in a concise and more readable way, especially when there is a lot of repetition in the setup for each of the different test cases.
- Use the `@pytest.mark.parametrize` decorator to define a parametrized test.

::::::::::::::::::::::::::::::::::::::::::::::::

