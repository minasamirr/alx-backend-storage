#!/usr/bin/env python3
"""
Script to return all students sorted by average score from a MongoDB collection.
"""


def top_students(mongo_collection):
    """
    Return a list of students sorted by their average score.

    Args:
        mongo_collection (Collection): The pymongo collection object.

    Returns:
        List[Dict]: A list of students sorted by their average score.

    Example:
        top_students = top_students(students_collection)
    """
    return mongo_collection.aggregate(
            [
                {
                    '$project': {
                        '_id': 1,
                        'name': 1,
                        'averageScore': {
                            '$avg': {
                                '$avg': '$topics.score',
                            },
                        },
                        'topics': 1,
                    },
                },
                {
                    '$sort': {'averageScore': -1},
                },
            ]
        )
