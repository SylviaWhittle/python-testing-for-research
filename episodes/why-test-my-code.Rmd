---
title: 'why-test-my-code'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- Why test my code?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Understand how testing can help to ensure that code is working as expected

::::::::::::::::::::::::::::::::::::::::::::::::

## Catching bugs

Whether you are writing the occasional script or developing a large software, mistakes are inevitable. Sometimes you don't even know when a mistake creeps into the code, and it gets published. 

Consider the following function:

```python
def add(a, b):
    return a - b
```

When writing this function, I made a mistake. I accidentally wrote `a - b` instead of `a + b`. This is a simple mistake, but it could have serious consequences in a project.

When writing the code, I could have tested this function by manually trying it with different input and checking the output, but:

- This takes time.
- I might forget to test it again when we make changes to the code later on.
- Nobody else in my team knows if I tested it, or how I tested it, and therefore whether they can trust it.

This is where automated testing comes in.

## Automated testing

Automated testing is where we write code that checks that our code works as expected. Every time we make a change, we can run our tests to automatically make sure that our code still works as expected.

If we were writing a test from scratch for the `add` function, think for a moment on how we would do it.
We would need to write a function that runs the `add` function on a set of inputs, checking each case to ensure it does what we expect. Let's write a test for the `add` function and call it `test_add`:

```python
def test_add():
   # Check that it adds two positive integers
   if add(1, 2) != 3:
      print("Test failed!")
   # Check that it adds zero
   if add(5, 0) != 5:
      print("Test failed!")
   # Check that it adds two negative integers
   if add(-1, -2) != -3:
      print("Test failed!")
```

Here we check that the function works for a set of test cases. This ensures that it works for positive numbers, negative numbers, and zero. This type of function is called a "test".


::::::::::::::::::::::::::::::::::::: challenge 

## Challenge 1: What could go wrong?

When writing functions, sometimes we don't anticipate all the ways that they could go wrong.

Take a moment to think about what might go wrong with this function to calculate the gradient between two points:

```python
def gradient(x1, y1, x2, y2):
    return (y2 - y1) / (x2 - x1)
```

:::::::::::::::::::::::: solution 

## Answer
 
The function will crash if `x2 - x1` is zero.

If we wrote a test for this function, it may have helped us to catch this unexpected behaviour:

```python
def test_gradient():
   if gradient(1, 1, 2, 2) != 1:
      print("Test failed!")
   if gradient(1, 1, 2, 3) != 2:
      print("Test failed!")
   if gradient(1, 1, 1, 2) != "Undefined":
      print("Test failed!")
```

And we could have ammened the function:

```python
def gradient(x1, y1, x2, y2):
   if x2 - x1 == 0:
      return "Undefined"
   return (y2 - y1) / (x2 - x1)
```


:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::


## Finding the root cause of a bug

When a test fails, it can help us to find the root cause of a bug. For example, consider the following function:

```python

def multiply(a, b):
      return a * a

def divide(a, b):
      return a / b

def triangle_area(base, height):
      return divide(multiply(base, height), 2)
```

There is a bug in this code too, but since we have several functions calling each other, it is not immediately obvious where the bug is. Also, the bug is not likely to cause a crash, so we won't get a helpful error message telling us what went wrong. If a user happened to notice that there was an error, then we would have to check `triangle_area` to see if the formula we used is right, then `multiply`, and `divide` to see if they were working as expected too!

However, if we had written tests for these functions, then we would have seen that both the `triangle_area` and `multiply` functions were not working as expected, allowing us to quickly see that the bug was in the `multiply` function without having to check the other functions.


::::::::::::::::::::::::::::::::::::: challenge

## Challenge 2: What could go wrong?

Consider a function that controls an oven that automatically cooks food using just its weight.

- What checks might we add to make sure it is not dangerous to use?

```python

def cook_by_weight(weight):
   
   ...

   return cook_time, target_temperature
```

:::::::::::::::::::::::: solution

## Answer

There are lots of checks that we could add, such as:

- Checking if the weight is too large for the oven to handle
- Checking if the weight is too small and could cause the food to burn
- Checking that the cooking time is not too long
- Checking that the target temperature is not dangerously high

:::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::: keypoints 

- Automated testing helps to catch hard to spot errors in code.
- They help to find the root cause of a bug when a test fails in complex functions.
- They reduce the time spent manually verifying (and re-verifying!) that code works.
- They help to ensure that code works as expected when changes are made.
- They are especially useful when working in a team, as they help to ensure that everyone can trust the code.


::::::::::::::::::::::::::::::::::::::::::::::::

