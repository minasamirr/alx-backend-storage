#!/usr/bin/env python3
"""
Script to insert a new document in a collection based on kwargs.
"""


def insert_school(mongo_collection, **kwargs):
    """
    Insert a new document in a collection based on kwargs.

    Args:
        mongo_collection (Collection): The pymongo collection object.
        kwargs (Dict[str, Any]): Key-value pairs to be inserted as a document.

    Returns:
        Any: The ID of the inserted document.
    """
    result = mongo_collection.insert_one(kwargs)
    return result.inserted_id
