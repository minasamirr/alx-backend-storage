#!/usr/bin/env python3
"""
Script to return the list of schools having a specific topic.
"""


def schools_by_topic(mongo_collection, topic):
    """
    Return the list of schools having a specific topic.

    Args:
        mongo_collection (Collection): The pymongo collection object.
        topic (str): The topic to search for.

    Returns:
        List[Dict]: A list of schools having the specific topic.
    """
    return list(mongo_collection.find({"topics": topic}))
