---
title: 'Unit tests & Testing Practices'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- What to do about complex functions & tests?
- What are some testing best practices for testing?
- How far should I go with testing?
- How do I add tests to an existing project?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Be able to write effective unit tests for more complex functions
- Understand the AAA pattern for structuring tests
- Understand the benefits of test driven development
- Know how to handle randomness in tests

::::::::::::::::::::::::::::::::::::::::::::::::

## But what about complicated functions?

Some of the functions that you write will be more complex, resulting in tests that are very complex and hard to debug if they fail. Take this function as an example:

```python
def process_data(data: list, maximum_value: float):

    # Remove negative values
    data_negative_removed = []
    for i in range(len(data)):
        if data[i] >= 0:
            data_negative_removed.append(data[i])

    # Remove values above the maximum value
    data_maximum_removed = []
    for i in range(len(data_negative_removed)):
        if data_negative_removed[i] <= maximum_value:
            data_maximum_removed.append(data_negative_removed[i])
    
    # Calculate the mean
    mean = sum(data_maximum_removed) / len(data_maximum_removed)

    # Calculate the standard deviation
    variance = sum([(x - mean) ** 2 for x in data_maximum_removed]) / len(data_maximum_removed)
    std_dev = variance ** 0.5

    return mean, std_dev
```

A test for this function might look like this:

```python
def test_process_data():
    data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    maximum_value = 5
    mean, std_dev = process_data(data, maximum_value)
    assert mean == 3
    assert std_dev == 1.5811388300841898

```

This test is very complex and hard to debug if it fails. Imagine if the calculation of the mean broke - the test would fail but it would not tell us what part of the function was broken, requiring us to 
check each function manually to find the bug. Not very efficient!

## Unit Testing

The process of unit testing is a fundamental part of software development. It is where you test individual units or components of a software instead of multiple things at once.
For example, if you were adding tests to a car, you would want to test the wheels, the engine, the brakes, etc. separately to make sure they all work as expected before testing that the car could drive to the shops.
The goal with unit testing is to validate that each unit of the software performs as designed. A unit is the smallest testable part of your code.
A unit test usually has one or a few inputs and usually a single output.

The above function could usefully be broken down into smaller functions, each of which could be tested separately. This would make the tests easier to write and maintain.

```python
def remove_negative_values(data: list):
    data_negatives_removed = []
    for i in range(len(data)):
        if data[i] >= 0:
            data_negatives_removed.append(data[i])
    return data

def remove_values_above_maximum(data: list, maximum_value: float):
    data_maximum_removed = []
    for i in range(len(data)):
        if data[i] <= maximum_value:
            data_maximum_removed.append(data[i])
    return data

def calculate_mean(data: list):
    return sum(data) / len(data)

def calculate_std_dev(data: list):
    mean = calculate_mean(data)
    variance = sum([(x - mean) ** 2 for x in data]) / len(data)
    return variance ** 0.5

def process_data(data: list, maximum_value: float):
    # Remove negative values
    data = remove_negative_values(data)
    # Remove values above the maximum value
    data = remove_values_above_maximum(data, maximum_value)
    # Calculate the mean
    mean = calculate_mean(data)
    # Calculate the standard deviation
    std_dev = calculate_std_dev(data)
    return mean, std_dev
```

Now we can write tests for each of these functions separately:

```python
def test_remove_negative_values():
    data = [1, -2, 3, -4, 5, -6, 7, -8, 9, -10]
    assert remove_negative_values(data) == [1, 3, 5, 7, 9]

def test_remove_values_above_maximum():
    data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    maximum_value = 5
    assert remove_values_above_maximum(data, maximum_value) == [1, 2, 3, 4, 5]

def test_calculate_mean():
    data = [1, 2, 3, 4, 5]
    assert calculate_mean(data) == 3

def test_calculate_std_dev():
    data = [1, 2, 3, 4, 5]
    assert calculate_std_dev(data) == 1.5811388300841898

def test_process_data():
    data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    maximum_value = 5
    mean, std_dev = process_data(data, maximum_value)
    assert mean == 3
    assert std_dev == 1.5811388300841898
```

These tests are much easier to read and understand, and if one of them fails, it is much easier to see which part of the function is broken.
This is the principle of unit testing: breaking down complex functions into smaller, testable units.

## AAA pattern

When writing tests, it is a good idea to follow the AAA pattern:

- Arrange: Set up the data and the conditions for the test
- Act: Perform the action that you are testing
- Assert: Check that the result of the action is what you expect

It is a standard pattern in unit testing and is used in many testing frameworks.
This makes your tests easier to read and understand for both yourself and others reading your code.

```python
def test_calculate_mean():
    # Arrange
    data = [1, 2, 3, 4, 5]
    
    # Act
    mean = calculate_mean(data)
    
    # Assert
    assert mean == 3
```

## Test Driven Development (TDD)

Test Driven Development (TDD) is a software development process that focuses on writing tests before writing the code.
This can have several benefits:

- It forces you to think about the requirements of the code before you write it, this is especially useful in research.
- It can help you to write cleaner, more modular code by breaking down complex functions into smaller, testable units.
- It can help you to catch bugs early in the development process.

Without the test driven development process, you might write the code first and then try to write tests for it afterwards. This can lead to tests that are hard to write and maintain, and can result in bugs that are hard to find and fix.

The TDD process usually follows these steps:

1. Write a failing test
2. Write the minimum amount of code to make the test pass
3. Refactor the code to make it clean and maintainable

Here is an example of the TDD process:

1. Write a failing test

```python

def test_calculate_mean():
    # Arrange
    data = [1, 2, 3, 4, 5]
    
    # Act
    mean = calculate_mean(data)
    
    # Assert
    assert mean == 3.5
```

2. Write the minimum amount of code to make the test pass

```python
def calculate_mean(data: list):
    total = 0
    for i in range(len(data)):
        total += data[i]
    mean = total / len(data)
    return mean
```

3. Refactor the code to make it clean and maintainable

```python
def calculate_mean(data: list):
    if len(data) == 0:
        return 0
    return sum(data) / len(data)
```

This process can help you to write clean, maintainable code that is easy to test and debug.

Of course, in research, sometimes you might not know exactly what the requirements of the code are before you write it. In this case, you can still use the TDD process, but you might need to iterate on the tests and the code as you learn more about the problem you are trying to solve.

## Randomness in tests

Some functions use randomness, which you might assume means we cannot write tests for them.
However using random seeds, we can make this randomness deterministic and write tests for these functions.

```python
import random

def random_number():
    return random.randint(1, 10)

def test_random_number():
    random.seed(0)
    assert random_number() == 1
    assert random_number() == 2
    assert random_number() == 3
```

Random seeds work by setting the initial state of the random number generator.
This means that if you set the seed to the same value, you will get the same sequence of random numbers each time you run the function.


::::::::::::::::::::::::::::::::::::: challenge 

## Challenge: Write your own unit tests

Take this complex function, break it down and write unit tests for it.

- Create a new directory called `statistics` in your project directory
- Create a new file called `stats.py` in the `statistics` directory
- Write the following function in `stats.py`:

```python
import random

def randomly_sample_and_filter_participants(
    participants: list, 
    sample_size: int, 
    min_age: int, 
    max_age: int, 
    min_height: int, 
    max_height: int
):
    """Participants is a list of tuples, containing the age and height of each participant
    participants = [
                      {age: 25, height: 180}, 
                      {age: 30, height: 170}, 
                      {age: 35, height: 160}, 
    ]
    """
    
    # Get the indexes to sample
    indexes = random.sample(range(len(participants)), sample_size)

    # Get the sampled participants
    sampled_participants = []
    for i in indexes:
        sampled_participants.append(participants[i])
    
    # Remove participants that are outside the age range
    sampled_participants_age_filtered = []
    for participant in sampled_participants:
        if participant['age'] >= min_age and participant['age'] <= max_age:
            sampled_participants_age_filtered.append(participant)
    
    # Remove participants that are outside the height range
    sampled_participants_height_filtered = []
    for participant in sampled_participants_age_filtered:
        if participant['height'] >= min_height and participant['height'] <= max_height:
            sampled_participants_height_filtered.append(participant)

    return sampled_participants_height_filtered
```

- Create a new file called `test_stats.py` in the `statistics` directory
- Write unit tests for the `randomly_sample_and_filter_participants` function in `test_stats.py`

:::::::::::::::::::::::: solution 

The function can be broken down into smaller functions, each of which can be tested separately:

```python
import random

def sample_participants(
    participants: list, 
    sample_size: int
):
    indexes = random.sample(range(len(participants)), sample_size)
    sampled_participants = []
    for i in indexes:
        sampled_participants.append(participants[i])
    return sampled_participants

def filter_participants_by_age(
    participants: list, 
    min_age: int, 
    max_age: int
):
    filtered_participants = []
    for participant in participants:
        if participant['age'] >= min_age and participant['age'] <= max_age:
            filtered_participants.append(participant)
    return filtered_participants

def filter_participants_by_height(
    participants: list, 
    min_height: int, 
    max_height: int
):
    filtered_participants = []
    for participant in participants:
        if participant['height'] >= min_height and participant['height'] <= max_height:
            filtered_participants.append(participant)
    return filtered_participants

def randomly_sample_and_filter_participants(
    participants: list, 
    sample_size: int, 
    min_age: int, 
    max_age: int, 
    min_height: int, 
    max_height: int
):
    sampled_participants = sample_participants(participants, sample_size)
    age_filtered_participants = filter_participants_by_age(sampled_participants, min_age, max_age)
    height_filtered_participants = filter_participants_by_height(age_filtered_participants, min_height, max_height)
    return height_filtered_participants
```

Now we can write tests for each of these functions separately, remembering to set the random seed to make the randomness deterministic:

```python
import random

def test_sample_participants():
    # set random seed
    random.seed(0)

    participants = [
        {'age': 25, 'height': 180},
        {'age': 30, 'height': 170},
        {'age': 35, 'height': 160},
    ]
    sample_size = 2
    sampled_participants = sample_participants(participants, sample_size)
    expected = [{'age': 30, 'height': 170}, {'age': 35, 'height': 160}]
    assert sampled_participants == expected

def test_filter_participants_by_age():
    participants = [
        {'age': 25, 'height': 180},
        {'age': 30, 'height': 170},
        {'age': 35, 'height': 160},
    ]
    min_age = 30
    max_age = 35
    filtered_participants = filter_participants_by_age(participants, min_age, max_age)
    expected = [{'age': 30, 'height': 170}, {'age': 35, 'height': 160}]
    assert filtered_participants == expected

def test_filter_participants_by_height():
    participants = [
        {'age': 25, 'height': 180},
        {'age': 30, 'height': 170},
        {'age': 35, 'height': 160},
    ]
    min_height = 160
    max_height = 170
    filtered_participants = filter_participants_by_height(participants, min_height, max_height)
    expected = [{'age': 30, 'height': 170}, {'age': 35, 'height': 160}]
    assert filtered_participants == expected

def test_randomly_sample_and_filter_participants():
    # set random seed
    random.seed(0)

    participants = [
        {"age": 25, "height": 180},
        {"age": 30, "height": 170},
        {"age": 35, "height": 160},
        {"age": 38, "height": 165},
        {"age": 40, "height": 190},
        {"age": 45, "height": 200},
    ]
    sample_size = 5
    min_age = 28
    max_age = 42
    min_height = 159
    max_height = 172
    filtered_participants = randomly_sample_and_filter_participants(
        participants, sample_size, min_age, max_age, min_height, max_height
    )
    expected = [{"age": 38, "height": 165}, {"age": 30, "height": 170}, {"age": 35, "height": 160}]
    assert filtered_participants == expected
```

These tests are much easier to read and understand, and if one of them fails, it is much easier to see which part of the function is broken.

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::


## Adding tests to an existing project

You may have an existing project that does not have any tests yet. Adding tests to an existing project can be a daunting task and it can be hard to know where to start.

In general, it's a good idea to start by adding regression tests to your most important functions.
Regression tests are tests that simply check that the output of a function doesn't change when you make changes to the code.
They don't check the individual components of the functions like unit testing does.

For example if you had a long processing pipeline that returns a single number, 23 when provided a certain set of inputs, you could write a regression test that checks
that the output is still 23 when you make changes to the code.

After adding regression tests, you can start adding unit tests to the individual functions in your code, starting with the more commonly used / likely to break functions such as ones
that handle data processing or input/output.

## Should we aim for 100% test coverage?

Although tests add reliability to your code, it's not always practicable to spend so much development time writing tests.
When time is limited, it's often better to only write tests for the most critical parts of the code as opposed to rigorously testing every function.

You should discuss with your team how much of the code you think should be tested, and what the most critical parts of the code are in order to prioritize your time.

::::::::::::::::::::::::::::::::::::: keypoints 

- Complex functions can be broken down into smaller, testable units.
- Testing each unit separately is called unit testing.
- The AAA pattern is a good way to structure your tests.
- Test driven development can help you to write clean, maintainable code.
- Randomness in tests can be made deterministic using random seeds.
- Adding tests to an existing project can be done incrementally, starting with regression tests.

::::::::::::::::::::::::::::::::::::::::::::::::

