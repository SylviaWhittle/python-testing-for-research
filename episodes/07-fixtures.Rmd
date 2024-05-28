---
title: 'Fixtures'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How to reuse data and objects in tests?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Learn how to use fixtures to store data and objects for use in tests.

::::::::::::::::::::::::::::::::::::::::::::::::

## Repetitiveness in tests

When writing more complex tests, you may find that you need to reuse data or objects across multiple tests.

Here is an example of a set of tests that re-use the same data a lot.
We have a class, `Point`, that represents a point in 2D space. We have a few tests that check the behaviour of the class.
Notice how we have to repeat the extact same setup code in each test.

```python

class Point:
   def __init__(self, x, y):
      self.x = x
      self.y = y

   def distance_from_origin(self):
      return (self.x ** 2 + self.y ** 2) ** 0.5

   def move(self, dx, dy):
      self.x += dx
      self.y += dy
   
   def reflect_over_x(self):
      self.y = -self.y

   def reflect_over_y(self):
      self.x = -self.x

```

```python

def test_distance_from_origin():
   # Positive coordinates
   point_positive_coords = Point(3, 4)
   # Negative coordinates
   point_negative_coords = Point(-3, -4)
   # Mix of positive and negative coordinates
   point_mixed_coords = Point(-3, 4)

   assert point_positive_coords.distance_from_origin() == 5.0
   assert point_negative_coords.distance_from_origin() == 5.0
   assert point_mixed_coords.distance_from_origin() == 5.0

def test_move():
   # Repeated setup again...

   # Positive coordinates
   point_positive_coords = Point(3, 4)
   # Negative coordinates
   point_negative_coords = Point(-3, -4)
   # Mix of positive and negative coordinates
   point_mixed_coords = Point(-3, 4)


   # Test logic
   point_positive_coords.move(2, -1)
   point_negative_coords.move(2, -1)
   point_mixed_coords.move(2, -1)

   assert point_positive_coords.x == 5
   assert point_positive_coords.y == 3
   assert point_negative_coords.x == -1
   assert point_negative_coords.y == -5
   assert point_mixed_coords.x == -1
   assert point_mixed_coords.y == 3

def test_reflect_over_x():
   # Yet another setup repetition

   # Positive coordinates
   point_positive_coordinates = Point(3, 4)
   # Negative coordinates
   point_negative_coordinates = Point(-3, -4)
   # Mix of positive and negative coordinates
   point_mixed_coordinates = Point(-3, 4)

   # Test logic
   point_positive_coordinates.reflect_over_x()
   point_negative_coordinates.reflect_over_x()
   point_mixed_coordinates.reflect_over_x()

   assert point_positive_coordinates.x == 3
   assert point_positive_coordinates.y == -4
   assert point_negative_coordinates.x == -3
   assert point_negative_coordinates.y == 4
   assert point_mixed_coordinates.x == -3
   assert point_mixed_coordinates.y == -4


def test_reflect_over_y():
   # One more time...

   # Positive coordinates
   point_positive_coordinates = Point(3, 4)
   # Negative coordinates
   point_negative_coordinates = Point(-3, -4)
   # Mix of positive and negative coordinates
   point_mixed_coordinates = Point(-3, 4)

   # Test logic
   point_positive_coordinates.reflect_over_y()
   point_negative_coordinates.reflect_over_y()
   point_mixed_coordinates.reflect_over_y()

   assert point_positive_coordinates.x == -3
   assert point_positive_coordinates.y == 4
   assert point_negative_coordinates.x == 3
   assert point_negative_coordinates.y == -4
   assert point_mixed_coordinates.x == 3
   assert point_mixed_coordinates.y == 4

```

## Fixtures

Pytest provides a way to store data and objects for use in tests - fixtures.

Fixtures are simply functions that return a value, and can be used in tests by passing them as arguments.
Pytest magically knows that any test that requires a fixture as an argument should run the fixture function first, and pass the result to the test.

Fixtures are defined using the `@pytest.fixture` decorator.
(Don't worry if you are not aware of decorators, they are just ways of flagging functions to do something special - in this case, to let pytest know that this function is a fixture.)

Here is a very simple fixture to demonstrate this:

```python
import pytest

@pytest.fixture
def my_fixture():
   return "Hello, world!"

def test_my_fixture(my_fixture):
   assert my_fixture == "Hello, world!"
```

Here, Pytest will notice that `my_fixture` is a fixture due to the `@pytest.fixture` decorator, and will run `my_fixture`, then pass the result into `test_my_fixture`.

Now let's see how we can improve the tests for the `Point` class using fixtures:

```python
import pytest

@pytest.fixture
def point_positive_3_4():
   return Point(3, 4)

@pytest.fixture
def point_negative_3_4():
   return Point(-3, -4)

@pytest.fixture
def point_mixed_3_4():
   return Point(-3, 4)

def test_distance_from_origin(point_positive_3_4, point_negative_3_4, point_mixed_3_4):
   assert point_positive_3_4.distance_from_origin() == 5.0
   assert point_negative_3_4.distance_from_origin() == 5.0
   assert point_mixed_3_4.distance_from_origin() == 5.0

def test_move(point_positive_3_4, point_negative_3_4, point_mixed_3_4):
   point_positive_3_4.move(2, -1)
   point_negative_3_4.move(2, -1)
   point_mixed_3_4.move(2, -1)

   assert point_positive_3_4.x == 5
   assert point_positive_3_4.y == 3
   assert point_negative_3_4.x == -1
   assert point_negative_3_4.y == -5
   assert point_mixed_3_4.x == -1
   assert point_mixed_3_4.y == 3

def test_reflect_over_x(point_positive_3_4, point_negative_3_4, point_mixed_3_4):
   point_positive_3_4.reflect_over_x()
   point_negative_3_4.reflect_over_x()
   point_mixed_3_4.reflect_over_x()

   assert point_positive_3_4.x == 3
   assert point_positive_3_4.y == -4
   assert point_negative_3_4.x == -3
   assert point_negative_3_4.y == 4
   assert point_mixed_3_4.x == -3
   assert point_mixed_3_4.y == -4

def test_reflect_over_y(point_positive_3_4, point_negative_3_4, point_mixed_3_4):
   point_positive_3_4.reflect_over_y()
   point_negative_3_4.reflect_over_y()
   point_mixed_3_4.reflect_over_y()

   assert point_positive_3_4.x == -3
   assert point_positive_3_4.y == 4
   assert point_negative_3_4.x == 3
   assert point_negative_3_4.y == -4
   assert point_mixed_3_4.x == 3
   assert point_mixed_3_4.y == 4
```

With the setup code defined in the fixtures, the tests are more concise and it won't take as much effort to add more tests in the future.

::::::::::::::::::::::::::::::::::::: challenge 

## Challenge : Write your own fixture

In the unit testing lesson, we wrote several tests for sampling & filtering data. We turned a complex function into a properly unit tested set of functions
which greatly improved the readability and maintainability of the code, however we had to repeat the same setup code in each test.


Code:

```python
def sample_participants(participants: list, sample_size: int):
    indexes = random.sample(range(len(participants)), sample_size)
    sampled_participants = []
    for i in indexes:
        sampled_participants.append(participants[i])
    return sampled_participants


def filter_participants_by_age(participants: list, min_age: int, max_age: int):
    filtered_participants = []
    for participant in participants:
        if participant["age"] >= min_age and participant["age"] <= max_age:
            filtered_participants.append(participant)
    return filtered_participants


def filter_participants_by_height(participants: list, min_height: int, max_height: int):
    filtered_participants = []
    for participant in participants:
        if participant["height"] >= min_height and participant["height"] <= max_height:
            filtered_participants.append(participant)
    return filtered_participants


def randomly_sample_and_filter_participants(
    participants: list, sample_size: int, min_age: int, max_age: int, min_height: int, max_height: int
):
    sampled_participants = sample_participants(participants, sample_size)
    age_filtered_participants = filter_participants_by_age(sampled_participants, min_age, max_age)
    height_filtered_participants = filter_participants_by_height(age_filtered_participants, min_height, max_height)
    return height_filtered_participants
```

Tests:

```python
import random
from stats import sample_participants, filter_participants_by_age, filter_participants_by_height, randomly_sample_and_filter_participants

def test_sample_participants():
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
    sample_size = 2
    sampled_participants = sample_participants(participants, sample_size)
    expected = [{"age": 38, "height": 165}, {"age": 45, "height": 200}]
    assert sampled_participants == expected


def test_filter_participants_by_age():
    participants = [
        {"age": 25, "height": 180},
        {"age": 30, "height": 170},
        {"age": 35, "height": 160},
        {"age": 38, "height": 165},
        {"age": 40, "height": 190},
        {"age": 45, "height": 200},
    ]
    min_age = 30
    max_age = 35
    filtered_participants = filter_participants_by_age(participants, min_age, max_age)
    expected = [{"age": 30, "height": 170}, {"age": 35, "height": 160}]
    assert filtered_participants == expected


def test_filter_participants_by_height():
    participants = [
        {"age": 25, "height": 180},
        {"age": 30, "height": 170},
        {"age": 35, "height": 160},
        {"age": 38, "height": 165},
        {"age": 40, "height": 190},
        {"age": 45, "height": 200},
    ]
    min_height = 160
    max_height = 170
    filtered_participants = filter_participants_by_height(participants, min_height, max_height)
    expected = [{"age": 30, "height": 170}, {"age": 35, "height": 160}, {"age": 38, "height": 165}]
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

- Try making these tests more concise by creating a fixture for the input data.

:::::::::::::::::::::::: solution 

```python
import pytest

@pytest.fixture
def participants():
    return [
        {"age": 25, "height": 180},
        {"age": 30, "height": 170},
        {"age": 35, "height": 160},
        {"age": 38, "height": 165},
        {"age": 40, "height": 190},
        {"age": 45, "height": 200},
    ]

def test_sample_participants(participants):
   # set random seed
   random.seed(0)

   sample_size = 2
   sampled_participants = sample_participants(participants, sample_size)
   expected = [{"age": 38, "height": 165}, {"age": 45, "height": 200}]
   assert sampled_participants == expected

def test_filter_participants_by_age(participants):
   min_age = 30
   max_age = 35
   filtered_participants = filter_participants_by_age(participants, min_age, max_age)
   expected = [{"age": 30, "height": 170}, {"age": 35, "height": 160}]
   assert filtered_participants == expected

def test_filter_participants_by_height(participants):
   min_height = 160
   max_height = 170
   filtered_participants = filter_participants_by_height(participants, min_height, max_height)
   expected = [{"age": 30, "height": 170}, {"age": 35, "height": 160}, {"age": 38, "height": 165}]
   assert filtered_participants == expected

def test_randomly_sample_and_filter_participants(participants):
   # set random seed
   random.seed(0)

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

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::


Fixtures also allow you to set up and tear down resources that are needed for tests, such as database connections, files, or servers, but those are more advanced topics that we won't cover here.

### Fixture organisation

Fixtures can be placed in the same file as the tests, or in a separate file. If you have a lot of fixtures, it may be a good idea to place them in a separate file to keep your test files clean.
It is common to place fixtures in a file called `conftest.py` in the same directory as the tests.

For example you might have this structure:

```
project_directory/
│
├── tests/
│   ├── conftest.py
│   ├── test_my_module.py
│   ├── test_my_other_module.py
│
├── my_module.py
├── my_other_module.py
```

In this case, the fixtures defined in `conftest.py` can be used in any of the test files in the `tests` directory, provided that the fixtures are imported.

::::::::::::::::::::::::::::::::::::: keypoints 

- Fixtures are useful way to store data, objects and automations to re-use them in many different tests.
- Fixtures are defined using the `@pytest.fixture` decorator.
- Tests can use fixtures by passing them as arguments.
- Fixtures can be placed in a separate file or in the same file as the tests.

::::::::::::::::::::::::::::::::::::::::::::::::

