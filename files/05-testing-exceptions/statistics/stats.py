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
