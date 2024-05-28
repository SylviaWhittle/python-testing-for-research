import numpy as np
import pandas as pd

from stats import (
    sample_participants,
    filter_participants_by_age,
    filter_participants_by_height,
    randomly_sample_and_filter_participants,
    remove_anomalies,
    calculate_frequency,
    calculate_cumulative_sum,
    calculate_player_total_scores,
    calculate_player_average_scores,
)

import random


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


def test_remove_anomalies():
    """Test remove_anomalies function"""
    data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    maximum_value = 5
    minimum_value = 2
    expected_result = [2, 3, 4, 5]
    assert remove_anomalies(data, maximum_value, minimum_value) == expected_result


def test_calculate_frequency():
    """Test calculate_frequency function"""
    data = [1, 2, 3, 1, 2, 1, 1, 3, 3, 3]
    expected_result = {1: 4, 2: 2, 3: 4}
    assert calculate_frequency(data) == expected_result


def test_calculate_cumulative_sum():
    """Test calculate_cumulative_sum function"""
    array = np.array([1, 2, 3, 4, 5])
    expected_result = np.array([1, 3, 6, 10, 15])
    np.testing.assert_array_equal(calculate_cumulative_sum(array), expected_result)


def test_calculate_player_total_scores():
    """Test calculate_player_total_scores function"""
    participants = {
        "Alice": {"scores": np.array([1, 2, 3])},
        "Bob": {"scores": np.array([4, 5, 6])},
        "Charlie": {"scores": np.array([7, 8, 9])},
    }
    expected_result = {
        "Alice": {"scores": np.array([1, 2, 3]), "total_score": 6},
        "Bob": {"scores": np.array([4, 5, 6]), "total_score": 15},
        "Charlie": {"scores": np.array([7, 8, 9]), "total_score": 24},
    }
    np.testing.assert_equal(calculate_player_total_scores(participants), expected_result)


def test_calculate_player_average_scores():
    """Test calculate_player_average_scores function"""
    df = pd.DataFrame({"player": ["Alice", "Bob"], "score_1": [1, 3], "score_2": [2, 4]})
    expected_result = pd.DataFrame(
        {"player": ["Alice", "Bob"], "score_1": [1, 3], "score_2": [2, 4], "average_score": [1.5, 3.5]}
    )
    pd.testing.assert_frame_equal(calculate_player_average_scores(df), expected_result)
