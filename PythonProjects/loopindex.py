# IMPORTANT Your autotest cases will NOT work if you don’t load your sys.argv like below. For this assignment, 
# load in your sys.argv like so: loop_list = sys.argv[1:]
# The above loop_list a list-type variable which contain numbers that are string-typed (ex. ['1', '2', '3', '4', '5'])
# Create a program, loopindex.py. Your program should: Convert these string-type integers into integer-type. For each of the numbers in the list, add its own index position.
# Example 1 - If the argument is ['5', '5', '5'], the program should print: [5, 6, 7]
# Example 2 - If the argument is ['4', '11', '0', '0', '1'], the program should print: [4, 12, 2, 3, 5]

import sys

def loopindex():
    loop_list = sys.argv[1:]
    ind = 0                                         # Initialize an index counter

    for num in range(len(loop_list)):
        loop_list[num] = int(loop_list[num]) + ind  # Convert to integer and add index position
        ind += 1                                    # Increment counter

    print(loop_list)

loopindex()    
