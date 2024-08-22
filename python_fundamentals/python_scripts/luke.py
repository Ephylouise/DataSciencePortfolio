# Create a program, luke.py, using the following dictionary:
# relations = {'Darth Vader':'father', 'Leia':'sister', 'Han':'brother in law', 'R2D2':'droid', 'Rey':'Padawan', 'Tatooine':'homeworld'}
# The program will take one argument, corresponding to one of the relations’ keys. 
# The program will print out the statement: 'Luke, I am your x' Where x = the relationship.  
# For example, if the argument is Leia, it should print ‘Luke, I am your sister’ If the key is ‘Darth Vader’ you should instead print “No, I am your father”

import sys

def luke(s):
    relations = {'Darth Vader':'father', 'Leia':'sister', 'Han':'brother in law', 'R2D2':'droid', 'Rey':'Padawan', 'Tatooine':'homeworld'}

    if s == 'Darth Vader':
        print("No, I am your father")
    else:
        print(f'Luke, I am your {relations[s]}')

luke(sys.argv[1])
