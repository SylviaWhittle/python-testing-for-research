def power(value, exponent):
    """Raise a value to an exponent"""
    result = value
    for _ in range(exponent - 1):
        result *= value
    return result
