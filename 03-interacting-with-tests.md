---
title: 'Interacting with Tests'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How do I use pytest to run my tests?
- What does the output of pytest look like and how do I interpret it?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Understand how to run tests using pytest.
- Understand how to interpret the output of pytest.

::::::::::::::::::::::::::::::::::::::::::::::::

## Running pytest

As we saw in the previous lesson, you can invoke pytest using the `pytest` terminal command.
This searches within the current directory (and any sub-directories) for files that start or end with 'test'. For example:
`test_scripts.py`, `scripts_test.py`. It then searches for tests in these files, which are functions
(or classes) with names start with 'test', such as the `test_add` function we made in the previous lesson.

So far, we should have a file called `calculator.py` with an `add` and `multiply` function, and a file called `test_calculator.py` with `test_add` and `test_multiply` functions. If you are missing either of these, they are listed in the previous lesson.

To show off pytest's ability to search multiple files for tests, let's create a directory (folder) inside the current project directory called `advanced` where we will add some advanced calculator functionality.

- Create a directory called `advanced` inside your project directory.
- Inside this directory, create a file called `advanced_calculator.py` and a file called `test_advanced_calculator.py`.

Your project directory should now look like this:

```
project_directory/
│
├── calculator.py
├── test_calculator.py
│
└── advanced/
    ├── advanced_calculator.py
    └── test_advanced_calculator.py
```

- In the `advanced_calculator.py` file, add the following code:

```python
def power(value, exponent):
    """Raise a value to an exponent"""
    result = value
    for _ in range(exponent-1):
        result *= value
    return result
```

- In the `test_advanced_calculator.py` file, add the following test:

```python
from advanced_calculator import power

def test_power():
    """Test for the power function"""
    assert power(2, 3) == 8
    assert power(3, 3) == 27
```

- Now run `pytest` in the terminal. You should see that all tests pass due to the <span style="color:green">green</span> output.


Let's have a closer look at the output of pytest.

## Test output

When running pytest, there are usually two possible outcomes:

### Case 1: All tests pass
Let's break down the successful output in more detail.

```
=== test session starts ===
```
- The first line tells us that pytest has started running tests.
```
platform darwin -- Python 3.11.0, pytest-8.1.1, pluggy-1.4.0
```
- The next line just tells us the versions of several packages.
```
rootdir: /Users/sylvi/Documents/GitKraken/python-testing-for-research/episodes/files/03-interacting-with-tests
```
- The next line tells us where the tests are being searched for. In this case, it is your project directory. So any file that starts or ends with `test` anywhere in this directory will be opened and searched for test functions.
```
plugins: regtest-2.1.1
```
- This tells us what plugins are being used. In my case, I have a plugin called `regtest` that is being used, but you may not. This is fine and you can ignore it.

```
collected 3 items
```
- This simply tells us that 3 tests have been found and are ready to be run.

```
advanced/test_advanced_calculator.py . 
test_calculator.py ..    [100%]
```
- These two lines tells us that the tests in `test_calculator.py` and `advanced/test_advanced_calculator.py` have passed. Each `.` means that a test has passed. There are two of them beside `test_calculator.py` because there are two tests in `test_calculator.py` If a test fails, it will show an `F` instead of a `.`.

<div style="color:green">
```
=== 3 passed in 0.01s ===
```
</div>
- This tells us that the 3 tests have passed in 0.01 seconds.

### Case 2: Some or all tests fail
Now let's look at the output when the tests fail. Edit a test in `test_calculator.py` to make it fail (for example switching the `+` in `add` to a `-`), then run `pytest` again.

The start is much the same as before:

```
=== test session starts ===
platform darwin -- Python 3.11.0, pytest-8.1.1, pluggy-1.4.0
rootdir: /Users/sylvi/Documents/GitKraken/python-testing-for-research/episodes/files/03-interacting-with-tests
plugins: regtest-2.1.1
collected 3 items
```

But now we see that the tests have failed:

```
advanced/test_advanced_calculator.py .                                                                                                                                                                                                                                                                                                                                      [ 33%]
test_calculator.py F. 
```

These `F` tells us that a test has failed. The output then tells us which test has failed:

```
=== FAILURES ===

___ test_add ___
    def test_add():
        """Test for the add function"""
>       assert add(1, 2) == 3
E       assert -1 == 3
E       +  where -1 = add(1, 2)

test_calculator.py:21: AssertionError
```

This is where we get detailled information about what exactly broke in the test.

- The `>` chevron points to the line that failed in the test. In this case, the assertion `assert add(1, 2) == 3` failed.
- The following line tells us what the assertion tried to do. In this case, it tried to assert that the number -1 was equal to 3. Which of course it isn't.
- The next line goes into more detail about why it tried to equate -1 to 3. It tells us that -1 is the result of calling `add(1, 2)`.
- The final line tells us where the test failed. In this case, it was on line 21 of `test_calculator.py`.

Using this detailled output, we can quickly find the exact line that failed and know the inputs that caused the failure. From there, we can examine exactly what went wrong and fix it.

Finally, pytest prints out a short summary of all the failed tests:
```
=== short test summary info ===
FAILED test_calculator.py::test_add - assert -1 == 3
=== 1 failed, 2 passed in 0.01s ===
```

This tells us that one of our tests failed, and gives a short summary of what went wrong in this test and finally tells us that it took 0.01s to run the tests.


## Errors in collection

If pytest encounters an error while collecting the tests, it will print out an error message and won't run the tests.
This happens when there is a syntax error in one of the test files, or if pytest can't find the test files.

For example, if you remove the `:` from the end of the `def test_multiply():` function definition and run pytest, you will see the following output:

```
=== test session starts ===
platform darwin -- Python 3.11.0, pytest-8.1.1, pluggy-1.4.0
Matplotlib: 3.9.0
Freetype: 2.6.1
rootdir: /Users/sylvi/Documents/GitKraken/python-testing-for-research/episodes/files/03-interacting-with-tests.Rmd
plugins: mpl-0.17.0, regtest-2.1.1
collected 1 item / 1 error   

=== ERRORS ===
___ ERROR collecting test_calculator.py ___
...
E     File "/Users/sylvi/Documents/GitKraken/python-testing-for-research/episodes/files/03-interacting-with-tests.Rmd/test_calculator.py", line 14
E       def test_multiply()
E                          ^
E   SyntaxError: expected ':'
=== short test summary info ===
ERROR test_calculator.py
!!! Interrupted: 1 error during collection !!!
=== 1 error in 0.01s ===
```

This rather scary output is just telling us that there is a syntax error that needs fixing before the tests can be run.

## Pytest options

Pytest has a number of options that can be used to customize how tests are run. It is very useful to know about these options as they can help you to run tests the way you want and get more information if necessary about a test run.

### The verbose flag

The verbose flag `-v` can be used to get more detailed output from pytest. This can be useful when you want to see more information about the tests that are being run. For example, running `pytest -v` will give you more information about the tests that are being run, including the names of the tests and the files that they are in.

### The quiet flag

The quiet flag `-q` can be used to get less detailed output from pytest. This can be useful when you want to see less information about the tests that are being run. For example, running `pytest -q` will give you less information about the tests that are being run, including the names of the tests and the files that they are in.

### Running specific tests

In order to run a specific test, you can use the `-k` flag followed by the name of the test you want to run. For example, to run only the `test_add` test, you can run `pytest -k test_add`. This will only run the `test_add` test and ignore the `test_multiply` test.

Alternatively you can call a specific test using this notation: `pytest test_calculator.py::test_add`. This tells pytest to only run the `test_add` test in the `test_calculator.py` file.

### Stopping after the first failure

If you want to stop running tests after the first failure, you can use the `-x` flag. This will cause pytest to stop running tests after the first failure. This is useful when you have lots of tests that take a while to run.

::::::::::::::::::::::::::::::::::::: challenge

## Challenge - Experiment with pytest options

Try running pytest with the above options, editing the code to make the tests fail where necessary to see what happens.

::::::::::::::::::::::::::::::::: solution

- Run `pytest -v` to see more detailed output.

- Run `pytest -q` to see less detailed output.

- Run `pytest -k test_add` to run only the `test_add` test.

- Alternatively run `pytest test_calculator.py::test_add` to run only the `test_add` test.

- Run `pytest -x` to stop running tests after the first failure. (Make sure you have a failing test to see this in action).

:::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: keypoints 

- You can run multiple tests at once by running `pytest` in the terminal.
- Pytest searches for tests in files that start or end with 'test' in the current directory and subdirectories.
- The output of pytest tells you which tests have passed and which have failed and precisely why they failed.
- Flags such as `-v`, `-q`, `-k`, and `-x` can be used to get more detailed output, less detailed output, run specific tests, and stop running tests after the first failure, respectively.

::::::::::::::::::::::::::::::::::::::::::::::::

