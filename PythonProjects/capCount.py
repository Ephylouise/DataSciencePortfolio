# Create a program called capCount.py that has a function that takes in a string and 
# prints the number of capital letters in the first line, 
# then prints the sum of their indices in the second line.

import sys

def capCount(s):
    cap_count = 0                     # Initialize counters
    indices_sum = 0

    for index, char in enumerate(s): # enumerate() provides index and character of string
        if char.isupper():           # If character is capital
            cap_count += 1           # Then add to count
            indices_sum += index     # Add index to sum
    print(cap_count)
    print(indices_sum)

capCount(sys.argv[1])