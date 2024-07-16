#!/usr/bin/env python3
"""
Script to provide detailed statistics about Nginx logs stored in a MongoDB collection,
including the top 10 most present IPs.
"""

from pymongo import MongoClient


def log_stats() -> None:
    """
    Print detailed statistics about Nginx logs stored in the MongoDB collection.

    The function connects to the MongoDB 'logs' database and retrieves log statistics
    from the 'nginx' collection. It prints the total number of logs and the count of
    logs for each HTTP method (GET, POST, PUT, PATCH, DELETE). It also prints the
    number of logs where the method is GET and the path is '/status'. Additionally,
    it prints the top 10 most present IPs in the logs.
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

    # Aggregation to get the top 10 most present IPs
    top_ips = collection.aggregate([
        {"$group": {"_id": "$ip", "count": {"$sum": 1}}},
        {"$sort": {"count": -1}},
        {"$limit": 10}
    ])

    print("IPs:")
    for ip in top_ips:
        print(f"\t{ip['_id']}: {ip['count']}")


if __name__ == "__main__":
    log_stats()
