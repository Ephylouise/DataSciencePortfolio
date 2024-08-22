# IMPORTANT Your autotest cases will NOT work if you don’t load your sys.argv like below. For this assignment, load in your variables like this:
# set_a = sys.argv[1:] set_b = ['apple', 'banana', 'mango', 'orange']
# The above set_a is a list-type variable which contains words.
# Create a program, diffset.py. Your program should: Find the words that exists in set_a but are not in set_b. Print the output in a set format.
# Example 1 - If the set_a is ['apple', 'cherry'], the program should print: {'cherry'}
# Example 2 - If the set_a is ['apple', 'mango', 'pear', 'grape'], the program should print: {'grape', 'pear'}

import sys

def diffset():
    set_a = sys.argv[1:] 
    set_b = ['apple', 'banana', 'mango', 'orange']
    
    # Convert lists to sets
    set_a, set_b = set(set_a), set(set_b)    

    # Find words only in set a 
    only_a = set_a - set_b

    print(only_a)

diffset()
