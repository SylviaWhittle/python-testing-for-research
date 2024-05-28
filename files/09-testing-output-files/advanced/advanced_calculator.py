def power(value, exponent):
    """Raise a value to an exponent"""
    result = value
    for _ in range(exponent - 1):
        result *= value
    return result


def is_prime(n: int) -> bool:
    """Return True if n is a prime number, False otherwise"""
    if n < 2:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True
