"""A set of python scripts that need testing"""

def add(a, b):
    return a + b

def broken_check_if_prime(n):
    for i in range(2, n):
        if n % i == 0:
            return False
    return True
