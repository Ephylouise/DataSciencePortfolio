# Use this exact dictionary to complete this assignment (Do NOT alter this dictionary - points will be deducted if dictionary is changed):
# grades = {'Biology':80, 'Physics':88, 'Chemistry':98, 'Math':89, 'English':79, 'Music':67, 'History':68, 'Art':53, 'Economics':95, 'Psychology':88}
# Create a program, grades.py, that takes an argument (subject) and prints the average score excluding that subject, to two decimals.
# For example: If the argument is Biology, it should print 80.56 If the argument is Chemistry, it should print 78.56


import sys

def grades_excluding(s):
    grades = {'Biology':80, 'Physics':88, 'Chemistry':98, 'Math':89, 'English':79, 'Music':67, 'History':68, 'Art':53, 'Economics':95, 'Psychology':88}

    # Find the average of grades, excluding the input subject
    average = (sum(grades.values()) - grades[s]) / 9

    # Printing a string to include ':.2f' ensures a trailing zero won't be omitted
    print(f"{average:.2f}")

grades_excluding(sys.argv[1])