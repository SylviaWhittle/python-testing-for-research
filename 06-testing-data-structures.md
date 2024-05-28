---
title: 'Testing Data Structures'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How do you compare data structures such as lists and dictionaries?
- How do you compare objects in libraries like `pandas` and `numpy`?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Learn how to compare lists and dictionaries in Python.
- Learn how to compare objects in libraries like `pandas` and `numpy`.

::::::::::::::::::::::::::::::::::::::::::::::::

## Data structures

When writing tests for your code, you often need to compare data structures such as lists, dictionaries, and objects from libraries like `numpy` and `pandas`.
Here we will go over some of the more common data structures that you may use in research and how to test them.

### Lists

Python lists can be tested using the usual `==` operator as we do for numbers.

```python

def test_lists_equal():
    """Test that lists are equal"""
    # Create two lists
    list1 = [1, 2, 3]
    list2 = [1, 2, 3]
    # Check that the lists are equal
    assert list1 == list2

    # Two lists, different order
    list3 = [1, 2, 3]
    list4 = [3, 2, 1]
    assert list3 != list4

    # Create two different lists
    list5 = [1, 2, 3]
    list6 = [1, 2, 4]
    # Check that the lists are not equal
    assert list5 != list6

```

Note that the order of elements in the list matters. If you want to check that two lists contain the same elements but in different order, you can use the `sorted` function.

```python
def test_sorted_lists_equal():
    """Test that lists are equal"""
    # Create two lists
    list1 = [1, 2, 3]
    list2 = [1, 2, 3]
    # Check that the lists are equal
    assert sorted(list1) == sorted(list2)

    # Two lists, different order
    list3 = [1, 2, 3]
    list4 = [3, 2, 1]
    assert sorted(list3) == sorted(list4)

    # Create two different lists
    list5 = [1, 2, 3]
    list6 = [1, 2, 4]
    # Check that the lists are not equal
    assert sorted(list5) != sorted(list6)

```

### Dictionaries

Python dictionaries can also be tested using the `==` operator, however, the order of the keys does not matter.
This means that if you have two dictionaries with the same keys and values, but in different order, they will still be considered equal.

The reason for this is that dictionaries are unordered collections of key-value pairs.
(If you need to preserve the order of keys, you can use the `collections.OrderedDict` class.)

```python
def test_dictionaries_equal():
    """Test that dictionaries are equal"""
    # Create two dictionaries
    dict1 = {"a": 1, "b": 2, "c": 3}
    dict2 = {"a": 1, "b": 2, "c": 3}
    # Check that the dictionaries are equal
    assert dict1 == dict2

    # Create two dictionaries, different order
    dict3 = {"a": 1, "b": 2, "c": 3}
    dict4 = {"c": 3, "b": 2, "a": 1}
    assert dict3 == dict4

    # Create two different dictionaries
    dict5 = {"a": 1, "b": 2, "c": 3}
    dict6 = {"a": 1, "b": 2, "c": 4}
    # Check that the dictionaries are not equal
    assert dict5 != dict6
```

### numpy

Numpy is a common library used in research.
Instead of the usual `assert a == b`, numpy has its own testing functions that are more suitable for comparing numpy arrays.
These two functions are the ones you are most likely to use:
- `numpy.testing.assert_array_equal` is used to compare two numpy arrays.
- `numpy.testing.assert_allclose` is used to compare two numpy arrays with a tolerance for floating point numbers.
- `numpy.testing.assert_equal` is used to compare two objects such as lists or dictionaries that contain numpy arrays.

Here are some examples of how to use these functions:

```python

def test_numpy_arrays():
    """Test that numpy arrays are equal"""
    # Create two numpy arrays
    array1 = np.array([1, 2, 3])
    array2 = np.array([1, 2, 3])
    # Check that the arrays are equal
    np.testing.assert_array_equal(array1, array2)

# Note that np.testing.assert_array_equal even works with nested numpy arrays!

def test_nested_numpy_arrays():
    """Test that nested numpy arrays are equal"""
    # Create two nested numpy arrays
    array1 = np.array([[1, 2], [3, 4]])
    array2 = np.array([[1, 2], [3, 4]])
    # Check that the nested arrays are equal
    np.testing.assert_array_equal(array1, array2)

def test_numpy_arrays_with_tolerance():
    """Test that numpy arrays are equal with tolerance"""
    # Create two numpy arrays
    array1 = np.array([1.0, 2.0, 3.0])
    array2 = np.array([1.00009, 2.0005, 3.0001])
    # Check that the arrays are equal with tolerance
    np.testing.assert_allclose(array1, array2, atol=1e-3)
```

::::::::::::::::::::::::::::::::::::: callout

### Data structures with numpy arrays

When you have data structures that contain numpy arrays, such as lists or dictionaries, you cannot use `==` to compare them.
Instead, you can use `numpy.testing.assert_equal` to compare the data structures.

```python
def test_dictionaries_with_numpy_arrays():
    """Test that dictionaries with numpy arrays are equal"""
    # Create two dictionaries with numpy arrays
    dict1 = {"a": np.array([1, 2, 3]), "b": np.array([4, 5, 6])}
    dict2 = {"a": np.array([1, 2, 3]), "b": np.array([4, 5, 6])}
    # Check that the dictionaries are equal
    np.testing.assert_equal(dict1, dict2)
```

::::::::::::::::::::::::::::::::::::::::::::::::


### pandas

Pandas is another common library used in research for storing and manipulating datasets.
Pandas has its own testing functions that are more suitable for comparing pandas objects.
These two functions are the ones you are most likely to use:
- `pandas.testing.assert_frame_equal` is used to compare two pandas DataFrames.
- `pandas.testing.assert_series_equal` is used to compare two pandas Series.


Here are some examples of how to use these functions:

```python

def test_pandas_dataframes():
    """Test that pandas DataFrames are equal"""
    # Create two pandas DataFrames
    df1 = pd.DataFrame({"A": [1, 2, 3], "B": [4, 5, 6]})
    df2 = pd.DataFrame({"A": [1, 2, 3], "B": [4, 5, 6]})
    # Check that the DataFrames are equal
    pd.testing.assert_frame_equal(df1, df2)

def test_pandas_series():
    """Test that pandas Series are equal"""
    # Create two pandas Series
    s1 = pd.Series([1, 2, 3])
    s2 = pd.Series([1, 2, 3])
    # Check that the Series are equal
    pd.testing.assert_series_equal(s1, s2)
```


::::::::::::::::::::::::::::::::::::: challenge 

## Challenge : Comparing Data Structures

### Checking if lists are equal

In `statistics/stats.py` add this function to remove anomalies from a list:

```python
def remove_anomalies(data: list, maximum_value: float, minimum_value: float) -> list:
    """Remove anomalies from a list of numbers"""

    result = []

    for i in data:
        if i <= maximum_value and i >= minimum_value:
            result.append(i)
    
    return result
```

Then write a test for this function by comparing lists.

:::::::::::::::::::::::: solution 

```python
from stats import remove_anomalies

def test_remove_anomalies():
    """Test remove_anomalies function"""
    data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    maximum_value = 5
    minimum_value = 2
    expected_result = [2, 3, 4, 5]
    assert remove_anomalies(data, maximum_value, minimum_value) == expected_result
```

:::::::::::::::::::::::::::::::::

### Checking if dictionaries are equal

In `statistics/stats.py` add this function to calculate the frequency of each element in a list:

```python
def calculate_frequency(data: list) -> dict:
    """Calculate the frequency of each element in a list"""

    frequencies = {}

    # Iterate over each value in the list
    for value in data:
        # If the value is already in the dictionary, increment the count
        if value in frequencies:
            frequencies[value] += 1
        # Otherwise, add the value to the dictionary with a count of 1
        else:
            frequencies[value] = 1

    return frequencies
```

Then write a test for this function by comparing dictionaries.

:::::::::::::::::::::::: solution

```python
from stats import calculate_frequency

def test_calculate_frequency():
    """Test calculate_frequency function"""
    data = [1, 2, 3, 1, 2, 1, 1, 3, 3, 3]
    expected_result = {1: 4, 2: 2, 3: 4}
    assert calculate_frequency(data) == expected_result
```

:::::::::::::::::::::::::::::::::

### Checking if numpy arrays are equal

In `statistics/stats.py` add this function to calculate the cumulative sum of a numpy array:

```python
import numpy as np

def calculate_cumulative_sum(array: np.ndarray) -> np.ndarray:
    """Calculate the cumulative sum of a numpy array"""
    
    # don't use the built-in numpy function
    result = np.zeros(array.shape)
    result[0] = array[0]
    for i in range(1, len(array)):
        result[i] = result[i-1] + array[i]

    return result
```

Then write a test for this function by comparing numpy arrays.

:::::::::::::::::::::::: solution

```python
import numpy as np
from stats import calculate_cumulative_sum

def test_calculate_cumulative_sum():
    """Test calculate_cumulative_sum function"""
    array = np.array([1, 2, 3, 4, 5])
    expected_result = np.array([1, 3, 6, 10, 15])
    np.testing.assert_array_equal(calculate_cumulative_sum(array), expected_result)
```

:::::::::::::::::::::::::::::::::

### Checking if data structures with numpy arrays are equal

In `statistics/stats.py` add this function to calculate the total score of each player in a dictionary:

```python

def calculate_player_total_scores(participants: dict):
    """Calculate the total score of each player in a dictionary.
    
    Example input:
    {
        "Alice": {
            "scores": np.array([1, 2, 3])
        },
        "Bob": {
            "scores": np.array([4, 5, 6])
        },
        "Charlie": {
            "scores": np.array([7, 8, 9])
        },
    }

    Example output:
    {
        "Alice": {
            "scores": np.array([1, 2, 3]),
            "total_score": 6
        },
        "Bob": {
            "scores": np.array([4, 5, 6]),
            "total_score": 15
        },
        "Charlie": {
            "scores": np.array([7, 8, 9]),
            "total_score": 24
        },
    }
    """"
    
    for player in participants:
        participants[player]["total_score"] = np.sum(participants[player]["scores"])

    return participants
```

Then write a test for this function by comparing dictionaries with numpy arrays.

:::::::::::::::::::::::: solution

```python
import numpy as np
from stats import calculate_player_total_scores

def test_calculate_player_total_scores():
    """Test calculate_player_total_scores function"""
    participants = {
        "Alice": {
            "scores": np.array([1, 2, 3])
        },
        "Bob": {
            "scores": np.array([4, 5, 6])
        },
        "Charlie": {
            "scores": np.array([7, 8, 9])
        },
    }
    expected_result = {
        "Alice": {
            "scores": np.array([1, 2, 3]),
            "total_score": 6
        },
        "Bob": {
            "scores": np.array([4, 5, 6]),
            "total_score": 15
        },
        "Charlie": {
            "scores": np.array([7, 8, 9]),
            "total_score": 24
        },
    }
    np.testing.assert_equal(calculate_player_total_scores(participants), expected_result)
```

:::::::::::::::::::::::::::::::::

### Checking if pandas DataFrames are equal

In `statistics/stats.py` add this function to calculate the average score of each player in a pandas DataFrame:

```python
import pandas as pd

def calculate_player_average_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Calculate the average score of each player in a pandas DataFrame.
    
    Example input:
    |   | player  | score_1 | score_2 |
    |---|---------|---------|---------|
    | 0 | Alice   | 1       | 2       |
    | 1 | Bob     | 3       | 4       |

    Example output:
    |   | player  | score_1 | score_2 | average_score |
    |---|---------|---------|---------|---------------|
    | 0 | Alice   | 1       | 2       | 1.5           |
    | 1 | Bob     | 3       | 4       | 3.5           |
    """

    df["average_score"] = df[["score_1", "score_2"]].mean(axis=1)

    return df
```

Then write a test for this function by comparing pandas DataFrames.

Hint: You can create a dataframe like this:

```python
df = pd.DataFrame({
    "player": ["Alice", "Bob"],
    "score_1": [1, 3],
    "score_2": [2, 4]
})
```

:::::::::::::::::::::::: solution

```python
import pandas as pd
from stats import calculate_player_average_scores

def test_calculate_player_average_scores():
    """Test calculate_player_average_scores function"""
    df = pd.DataFrame({
        "player": ["Alice", "Bob"],
        "score_1": [1, 3],
        "score_2": [2, 4]
    })
    expected_result = pd.DataFrame({
        "player": ["Alice", "Bob"],
        "score_1": [1, 3],
        "score_2": [2, 4],
        "average_score": [1.5, 3.5]
    })
    pd.testing.assert_frame_equal(calculate_player_average_scores(df), expected_result)
```

:::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::: keypoints 

- You can test equality of lists and dictionaries using the `==` operator.
- Numpy arrays cannot be compared using the `==` operator. Instead, use `numpy.testing.assert_array_equal` and `numpy.testing.assert_allclose`.
- Data structures that contain numpy arrays should be compared using `numpy.testing.assert_equal`.
- Pandas DataFrames and Series should be compared using `pandas.testing.assert_frame_equal` and `pandas.testing.assert_series_equal`.

::::::::::::::::::::::::::::::::::::::::::::::::

