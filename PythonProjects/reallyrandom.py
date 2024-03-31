# Create program called reallyrandom.py that has a function that takes in three arguments and prints one integer. Your random seed should be set to 42. 
# The first argument should correspond to the size of a np.randint that has values from 0 to 10.
# The second is an integer that you will multiply the randint by.
# The third argument is a value you will index the result of the multiplication by. 
# You will print the integer that was indexed as ‘Your random value is x’ where x = the result of the indexing. 
# The program should not crash if the third value is larger than the first. Example: python3 reallyrandom.py 59 2 7
# Should generate the following: Your random value is 12

import sys
import numpy as np

def reallyrandom():
    np.random.seed(42)
    rand_int = np.random.randint(0, 10, int(sys.argv[1]))
    multi_int = rand_int * int(sys.argv[2])

    # Get the third argument as the index
    index = int(sys.argv[3])

    # Check if the index is within the bounds of the array
    if index < len(multi_int):
        # If within bounds, use the index to access the value
        index_multi = multi_int[index]
        print(f'Your random value is {index_multi}')
    else:
        # If out of bounds, do nothing
        pass

reallyrandom()
