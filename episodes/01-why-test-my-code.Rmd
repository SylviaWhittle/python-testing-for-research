---
title: 'Why Test My Code?'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- Why should I test my code?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Understand how testing can help to ensure that code is working as expected

::::::::::::::::::::::::::::::::::::::::::::::::

## What is software testing?

Software testing is the process of checking that code is working as expected. You may have data processing functions or automations that you use in your work - how do you know that they are doing what you expect them to do?

Software testing is most commonly done by writing code (tests) that check that your code work as expected.

This might seem like a lot of effort, so let's go over some of the reasons you might want to add tests to your project.


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

Here we check that the function works for a set of test cases. We ensure that it works for positive numbers, negative numbers, and zero. 


::::::::::::::::::::::::::::::::::::: challenge 

## Challenge 1: What could go wrong?

When writing functions, sometimes we don't anticipate all the ways that they could go wrong.

Take a moment to think about what is wrong, or might go wrong with these functions:

```python
def greet_user(name):
   return "Hello" + name + "!"
```

```python
def gradient(x1, y1, x2, y2):
    return (y2 - y1) / (x2 - x1)
```

:::::::::::::::::::::::: solution 

## Answer
 
The first function will incorrectly greet the user, as it is missing a space after "Hello". It would print `HelloAlice!` instead of `Hello Alice!`.

If we wrote a test for this function, we would have noticed that it was not working as expected:
```python
def test_greet_user():
   if greet_user("Alice") != "Hello Alice!":
      print("Test failed!")
```

The second function will crash if `x2 - x1` is zero.

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


## Increased confidence in code

When you have tests for your code, you can be more confident that it works as expected. This is especially important when you are working in a team or producing software for users, as it allows everyone to trust the code. If you have a test that checks that a function works as expected, then you can be confident that the function will work as expected, even if you didn't write it yourself.

## Forcing a more structured approach to coding

When you write tests for your code, you are forced to think more carefully about how your code behaves and how you will verify that it works as expected. This can help you to write more structured code, as you will need to think about how to test it as well as how it could fail.

::::::::::::::::::::::::::::::::::::: challenge

## Challenge 2: What could go wrong?

Consider a function that controls a driverless car.

- What checks might we add to make sure it is not dangerous to use?

```python

def drive_car(speed, direction):

   ... # complex car driving code

    return speed, direction, brake_status
   

```

:::::::::::::::::::::::: solution

## Answer

- We might want to check that the speed is within a safe range.

- We might want to check that the direction is a valid direction. ie not towards a tree, and if so, the car should be applying the brakes.

:::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: keypoints 

- Automated testing helps to catch hard to spot errors in code & find the root cause of complex issues.
- Tests reduce the time spent manually verifying (and re-verifying!) that code works.
- Tests help to ensure that code works as expected when changes are made.
- Tests are especially useful when working in a team, as they help to ensure that everyone can trust the code.

::::::::::::::::::::::::::::::::::::::::::::::::

