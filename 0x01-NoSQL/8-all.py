#!/usr/bin/env python3
"""
Script to list all documents in a collection.
"""


def list_all(mongo_collection):
    """
    List all documents in a collection.

    Args:
        mongo_collection (Collection): The pymongo collection object.

    Returns:
        List[Dict]: A list of documents in the collection.
    """
    return [doc for doc in mongo_collection.find()]
