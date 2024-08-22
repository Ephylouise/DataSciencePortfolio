# IMPORTANT Your autotest cases will NOT work if you don’t load your sys.argv like below. For this assignment, 
# load in your sys.argv like so: duck_goose = sys.argv[1:]
# The above duck_goose a list-type variable which contains lower-cased words, either 'duck' or 'goose' (ex. ['duck', 'duck', 'goose']).
# Create a program, duckgoose.py which removes all the ‘goose’ within the list then print the remaining list.
# Example - If the list is ['goose', 'duck', 'duck', 'goose', 'goose'], the program should print: ['duck', 'duck']

import sys

def duckgoose():
    duck_goose = sys.argv[1:]

    goose = 'goose'                 # Initialize object for string 'goose'

    while goose in duck_goose:      # While loop to remove all 'goose' strings
        duck_goose.remove(goose)

    print(duck_goose)

duckgoose()
