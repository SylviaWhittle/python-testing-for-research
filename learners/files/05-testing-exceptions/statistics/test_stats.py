from stats import (
    sample_participants,
    filter_participants_by_age,
    filter_participants_by_height,
    randomly_sample_and_filter_participants,
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
