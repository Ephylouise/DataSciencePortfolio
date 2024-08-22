# Create a program called countVowels.py that has a function that takes in a string 
# then prints the number of unique vowels in the string (regardless of it being upper or lower case).

import sys

def countVowels(s):
    vowels = "aeiou"
    found_vowels = set()

    for char in s.lower():  # convert the string to lowercase to ignore case
        if char in vowels:
            found_vowels.add(char) # .add to a set

    print(len(found_vowels)) # print number of unique vowels

countVowels(sys.argv[1])