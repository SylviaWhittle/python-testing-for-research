import numpy as np
import pandas as pd

import random


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


def remove_anomalies(data: list, maximum_value: float, minimum_value: float) -> list:
    """Remove anomalies from a list of numbers"""

    result = []

    for value in data:
        if minimum_value <= value <= maximum_value:
            result.append(value)

    return result


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


def calculate_cumulative_sum(array: np.ndarray) -> np.ndarray:
    """Calculate the cumulative sum of a numpy array"""

    # don't use the built-in numpy function
    result = np.zeros(array.shape)
    result[0] = array[0]
    for i in range(1, len(array)):
        result[i] = result[i - 1] + array[i]

    return result


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
    """

    for player in participants:
        participants[player]["total_score"] = np.sum(participants[player]["scores"])

    return participants


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


def very_complex_processing(data: list):

    # Do some very complex processing
    processed_data = [x * 2 for x in data]

    return processed_data
