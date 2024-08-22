# Create a program, palindrome.py, that has a function that takes one string argument and prints 
# a sentence indicating if the text is a palindrome. The function should consider only the 
# alphanumeric characters in the string, and not depend on capitalization, punctuation, or whitespace.
# If your string is a palindrome it should print: It’s a palindrome!
# If it is not a palindrome, it should print: It’s not a palindrome! 

import sys

def palindrome(s):
    s = ''.join(filter(lambda x: x.isalnum(), s.lower()))       # Only consider alphanumeric characters, make all lowercase

    middle = len(s)//2                                          # Assign midpoint (will exclude center character in odd length)
    first_half, rev_second_half = s[:middle], s[-middle:][::-1] # Split and reverse second half
    
    if first_half == rev_second_half:                           # If halves are mirrored, It's a palindrome!
        print("It's a palindrome!")
    else:
        print("It's not a palindrome!")

palindrome(sys.argv[1])