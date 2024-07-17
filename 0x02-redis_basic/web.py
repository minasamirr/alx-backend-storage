#!/usr/bin/env python3
"""
Web Cache module
"""

import redis
import requests
from typing import Callable
from functools import wraps


def url_access_tracker(method: Callable) -> Callable:
    """
    Decorator to track URL access counts in Redis.

    Args:
        method (Callable): The method to track.

    Returns:
        Callable: The wrapped method with URL tracking.
    """
    @wraps(method)
    def wrapper(url: str) -> str:
        """
        Wrapper function to track URL access.
        """
        redis_client = redis.Redis()
        redis_client.incr(f"count:{url}")
        return method(url)
    
    return wrapper


def cache_with_expiry(method: Callable) -> Callable:
    """
    Decorator to cache the result of a function with an expiry time in Redis.

    Args:
        method (Callable): The method to cache.

    Returns:
        Callable: The wrapped method with caching.
    """
    @wraps(method)
    def wrapper(url: str) -> str:
        """
        Wrapper function to cache results with expiry.
        """
        redis_client = redis.Redis()
        cached_page = redis_client.get(url)
        if cached_page:
            return cached_page.decode('utf-8')

        result = method(url)
        redis_client.setex(url, 10, result)
        return result

    return wrapper


@url_access_tracker
@cache_with_expiry
def get_page(url: str) -> str:
    """
    Get the HTML content of a URL.

    Args:
        url (str): The URL to fetch.

    Returns:
        str: The HTML content of the URL.
    """
    response = requests.get(url)
    return response.text


if __name__ == "__main__":
    url = "http://slowwly.robertomurray.co.uk"
    print(get_page(url))
