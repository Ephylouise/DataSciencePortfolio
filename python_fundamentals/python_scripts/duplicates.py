# IMPORTANT Your autotest cases will NOT work if you don’t load your sys.argv like below. For this assignment, 
# load in your sys.argv like so: duplicated_words = sys.argv[1:]
# The above duplicated_words is a list-type variable which contains whole bunch of lower-cased words (ex. ['hello', 'world', 'welcome', 'hello', 'again']).
# Create a program, duplicates.py. It should: Remove all duplicated words from the list Then print it in descending order of alphabets (from Z to A).
# Example 1 - If the list is ['hello', 'world', 'welcome', 'hello', 'again'], the program should print: ['world', 'welcome', 'hello', 'again']
# Example 2 - If the list is ['apple', 'banana', 'apple', 'orange', 'pear', 'banana'], the program should print: ['pear', 'orange', 'banana', 'apple']

import sys

def duplicates():
    duplicated_words = sys.argv[1:]
    unique_words = []                   # Create an empty result list
    for i in duplicated_words:
        if i not in unique_words:       # If word not in result, append it
            unique_words.append(i)

    unique_words.sort(reverse = True)   # Sort in descending alphabetical order
    print(unique_words)

duplicates()
