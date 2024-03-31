# IMPORTANT Your autotest cases will NOT work if you don’t load your sys.argv like below. For this assignment, load in your variables like this:
# set_a = sys.argv[1:] set_b = ['apple', 'banana', 'mango', 'orange']
# The above set_a is a list-type variable which contains words.
# Create a program, commonset.py. Your program should: Find the common words between set_a and set_b. Print the output in a set format.
# Example 1 - If the set_a is ['apple', 'banana', 'pear', 'grape'], the program should print: {'banana', 'apple'}
# Example 2 - If the set_a is ['mango', 'mango', 'mango', 'pear', 'grape'], the program should print: {'mango'}

import sys

def commonset():
    set_a = sys.argv[1:] 
    set_b = ['apple', 'banana', 'mango', 'orange']

    # Convert lists to sets
    set_a, set_b = set(set_a), set(set_b)    

    # Find the intersection of the two sets 
    com_set = set_a & set_b

    print(com_set)

commonset()
