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
    client = MongoClient('mongodb://127.0.0.1:27017')
    collection = client.logs.nginx

    print('{} logs'.format(collection.count_documents({})))

    methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
    print("Methods:")
    for method in methods:
        count = len(list(collection.find({'method': method})))
        print('\tmethod {}: {}'.format(method, count))

    status_check_count = len(list(
        collection.find({'method': 'GET', 'path': '/status'})
    ))
    print('{} status check'.format(status_check_count))


if __name__ == "__main__":
    log_stats()
