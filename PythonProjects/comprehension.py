# IMPORTANT Your autotest cases will NOT work if you don’t load your sys.argv like below. For this assignment, load in your sys.argv like so:
# my_ints = sys.argv[1:]
# The above my_ints a list-type variable which contain numbers that are string-typed (ex. ['1', '2', '3', '4', '5'])
# Create a program, comprehension.py. Your program should: Convert these string-type integers into integer-type. If the number within the list is divisible by 3, multiply it by 10, then replace it.
# For example: If your my_ints = ['1', '2', '3', '4', '5'], your output should be [1, 2, 30, 4, 5] If your my_ints = ['3', '30', '1', '15', '10'], your output should be [30, 300, 1, 150, 10]]

import sys

def comprehension():
    my_ints = sys.argv[1:]

    for num in range(len(my_ints)):
      my_ints[num] = int(my_ints[num])    # Convert string-type ti integer
      
      if my_ints[num] % 3 == 0:           # If divisible by 3, multiply by 10 and replace
        my_ints[num] = my_ints[num] * 10

    print(my_ints)

comprehension()
