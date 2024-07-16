#!/usr/bin/env python3
"""
Script to return all students sorted by average score from a MongoDB collection.
"""

from pymongo.collection import Collection
from typing import List, Dict


def top_students(mongo_collection: Collection) -> List[Dict]:
    """
    Return a list of students sorted by their average score.

    Args:
        mongo_collection (Collection): The pymongo collection object.

    Returns:
        List[Dict]: A list of students sorted by their average score.

    Example:
        top_students = top_students(students_collection)
    """
    return list(mongo_collection.aggregate([
        {
            "$project": {
                "name": 1,
                "averageScore": {"$avg": "$topics.score"}
            }
        },
        {
            "$sort": {"averageScore": -1}
        }
    ]))
