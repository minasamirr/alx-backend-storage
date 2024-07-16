#!/usr/bin/env python3
"""
Script to provide stats about Nginx logs stored in MongoDB.
"""
from pymongo import MongoClient

def log_stats() -> None:
    """
    Provide some stats about Nginx logs stored in MongoDB.
    """
    client = MongoClient('mongodb://localhost:27017/')
    db = client['logs']
    collection = db['nginx']

    log_count = collection.count_documents({})
    print(f"{log_count} logs")

    methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
    print("Methods:")
    for method in methods:
        count = collection.count_documents({"method": method})
        print(f"\tmethod {method}: {count}")

    status_check = collection.count_documents({"method": "GET", "path": "/status"})
    print(f"{status_check} status check")

if __name__ == "__main__":
    log_stats()
