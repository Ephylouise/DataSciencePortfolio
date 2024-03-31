# Create a program, shortest.py, that has a function that takes in a string argument and 
# prints a sentence indicating the shortest word in that string. 
# If there is more than one word print only the first. Your print statement should read:
# “The shortest word is x” Where x = the shortest word.  The word should be all uppercase.

import sys

def shortest(s):
    words = s.split()                   # Split the string into list of words
    shortest = min(words, key = len)    # Use 'min()' with 'key = len' to find shortest
    x = shortest.upper()                # Capitalize the word
    print(f'The shortest word is {x}')

shortest(sys.argv[1])
