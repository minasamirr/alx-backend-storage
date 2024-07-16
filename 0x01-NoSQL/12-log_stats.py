#!/usr/bin/env python3
"""
Script to provide statistics about Nginx logs stored in a MongoDB collection.
"""
from pymongo import MongoClient


def log_stats():
    """
    Print statistics about Nginx logs stored in the MongoDB collection.

    The function connects to the MongoDB 'logs' database and retrieves log statistics
    from the 'nginx' collection. It prints the total number of logs and the count of
    logs for each HTTP method (GET, POST, PUT, PATCH, DELETE). It also prints the
    number of logs where the method is GET and the path is '/status'.
    """
    client = MongoClient('mongodb://127.0.0.1:27017')
    nginx_collection = client.logs.nginx
    print('{} logs'.format(nginx_collection.count_documents({})))
    print('Methods:')
    methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE']
    for method in methods:
        req_count = len(list(nginx_collection.find({'method': method})))
        print('\tmethod {}: {}'.format(method, req_count))
    status_checks_count = len(list(
        nginx_collection.find({'method': 'GET', 'path': '/status'})
    ))
    print('{} status check'.format(status_checks_count))


if __name__ == '__main__':
    log_stats()
