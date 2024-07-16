#!/usr/bin/env python3
"""
Script to provide statistics about Nginx logs stored in a MongoDB collection.
"""
from pymongo import MongoClient


def log_stats() -> None:
    """
    Print statistics about Nginx logs stored in the MongoDB collection.

    The function connects to the MongoDB 'logs' database and retrieves log statistics
    from the 'nginx' collection. It prints the total number of logs and the count of
    logs for each HTTP method (GET, POST, PUT, PATCH, DELETE). It also prints the
    number of logs where the method is GET and the path is '/status'.
    """
    client = MongoClient('mongodb://localhost:27017/')
    db = client.logs
    collection = db.nginx

    log_count = collection.count_documents({})
    print(f"{log_count} logs")

    methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
    print("Methods:")
    for method in methods:
        count = collection.count_documents({"method": method})
        print(f"\tmethod {method}: {count}")

    status_check_count = collection.count_documents({"method": "GET", "path": "/status"})
    print(f"{status_check_count} status check")


if __name__ == "__main__":
    log_stats()
