# Create a program, counter.py. You are given a single string argument. Print a dictionary where the keys are 
# composed of each letter from a word and values are the sum of each letters’ appearances.
# Example 1 - If the word is “good”, the program should print: {'g': 1, 'o': 2, 'd': 1}
# Example 2 - If the word is “onomatopoeia”, the program should print: {'o': 4, 'n': 1, 'm': 1, 'a': 2, 't': 1, 'p': 1, 'e': 1, 'i': 1}

import sys

def counter(s):
    letter_dict = {}                        # Create empty dictionary

    for let in s:
        letter_dict[let] = s.count(let)     # Assign key-pairs as letter:letter count

    print(letter_dict)

counter(sys.argv[1])
