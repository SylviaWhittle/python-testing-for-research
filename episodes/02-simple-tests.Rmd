---
title: 'Simple Tests'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How to write a simple test?
- How to run the test?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Write a basic test.
- Run the test.
- Understand its output in the terminal.

::::::::::::::::::::::::::::::::::::::::::::::::

## Your first test

The most basic thing you will want to do in a test is check that an output for a
function is correct, by checking that it is equal to a certain value.

Let's take the `add` function example from the previous chapter and the test we
conceptualised for it and write it in code.

- Make a folder called `my_project` (or whatever you want to call it for these lessons)
and inside it, create a file called 'calculator.py', and another file called 'test_calculator.py'.

So your directory structure should look like this:

```bash
project_directory/
│
├── calculator.py
└── test_calculator.py
```

`calculator.py` will contain our Python functions that we want to test, and `test_calculator.py`
will contain our tests for those functions.

- In `calculator.py`, write the add function:

```python
def add(a, b):
  return a + b
```

- And in `test_calculator.py`, write the test for the add function that we conceptualised
in the previous lesson:

```python
# Import the add function so the test can use it
from calculator import add

def test_add():
   # Check that it adds two positive integers
   if add(1, 2) != 3:
      print("Test failed!")
      raise AssertionError("Test failed!")

   # Check that it adds zero
   if add(5, 0) != 5:
      print("Test failed!")
      raise AssertionError("Test failed!")

   # Check that it adds two negative integers
   if add(-1, -2) != -3:
      print("Test failed!")
      raise AssertionError("Test failed!")
```

(Note that the `AssertionError` is a way to tell Python to crash the test, so Pytest knows that the test has failed.)

This system of placing functions in a file and then tests for those functions in
another file, is a common pattern in software development. It allows you to keep your
code organised and separate your tests from your actual code.

With Pytest, the expectation is to name your test functions with the prefix `test_`.

Now, let's run the test. We can do this by running the following command in the terminal:

(make sure you're in the `my_project` directory before running this command)

```bash
❯ pytest ./
```

This command tells pytest to run all the tests in the current directory.

When you run the test, you should see that the test runs successfully, indicated
by some <span style="color:green">**green**</span>. text in the terminal. We will go through the output and what it means
in the next lesson, but for now, know that <span style="color:green">**green**</span> means that the test passed, and <span style="color:red">**red**</span>
means that the test failed.

Try changing the `add` function to return the wrong value, and run the test again to see that the test now fails
and the text turns <span style="color:red">**red**</span> - neat!

## The `assert` keyword

Writing these `if` blocks for each test case is cumbersome. Fortunately, Python
has a keyword to do this for us - the `assert` keyword.

The `assert` keyword checks if a statement is true and if it is, the test continues, but
if it isn't, then the test will crash, printing an error in the terminal. This enables us
to write succinct tests without lots of if-statements.

The `assert` keyword is used like this:

```python
assert add(1, 2) == 3
```

which is equivalent to:

```python
if add(1, 2) != 3:
  # Crash the test
  raise AssertionError
```

::::::::::::::::::::::::::::::::::::: challenge

## Challenge 1: Use the assert keyword to update the test for the add function

Use the `assert` keyword to update the test for the `add` function to make it more concise and readable.

Then re-run the test using `pytest ./` to check that it still passes.

:::::::::::::::::::::::: solution

```python
from calculator import add

def test_add():
  assert add(1, 2) == 3 # Check that it adds to positive integers
  assert add(5, 0) == 5 # Check that it adds zero
  assert add(-1, -2) == -3 # Check that it adds wro negative numbers
```

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

Now that we are using the `assert` keyword, pytest will let us know if our test fails.

What's more, is that if any of these assert statements fail, it will flag to
pytest that the test has failed, and pytest will let you know.


Make the `add` function return the wrong value, and run the test again to see that the test 
fails and the text turns <span style="color:red">**red**</span> as we expect.


So if this was a real testing situation, we would know to investigate the `add` function to see why it's not behaving as expected.

::::::::::::::::::::::::::::::::::::: challenge 

## Challenge 2: Write a test for a multiply function

Try using what we have covered to write a test for a `multiply` function that multiplies two numbers together.

- Place this multiply function in `calculator.py`:

```python
def multiply(a, b):
  return a * b
```

- Then write a test for this function in `test_calculator.py`. Remember to import the `multiply` function from `calculator.py` at the top of the file like this:

```python
from calculator import multiply
```

:::::::::::::::::::::::: solution

## Solution:
There are many different test cases that you could include, but it's important to check that different types of cases are covered. A test for this function could look like this:

```python
def test_multiply():
  # Check that positive numbers work
  assert multiply(5, 5) == 25
  # Check that multiplying by 1 works
  assert multiply(1, 5) == 5
  # Check that multiplying by 0 works
  assert multiply(0, 3) == 0
  # Check that negative numbers work
  assert multiply(-5, 2) == -10
```

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

Run the test using `pytest ./` to check that it passes. If it doesn't, don't worry, that's the point of testing - to find bugs in code.

::::::::::::::::::::::::::::::::::::: keypoints 

- The `assert` keyword is used to check if a statement is true and is a shorthand for writing `if` statements in tests.
- Pytest is invoked by running the command `pytest ./` in the terminal.
- `pytest` will run all the tests in the current directory, found by looking for files that start with `test_`.
- The output of a test is displayed in the terminal, with <span style="color:green">**green**</span> text indicating a successful test and <span style="color:red">**red**</span> text indicating a failed test.
- It's best practice to write tests in a separate file from the code they are testing. Eg: `scripts.py` and `test_scripts.py`.

::::::::::::::::::::::::::::::::::::::::::::::::

