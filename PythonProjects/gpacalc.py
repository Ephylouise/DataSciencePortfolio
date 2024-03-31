# Use the following dictionary to complete this assignment:
# {'A':4.0, 'A-':3.66, 'B+':3.33, 'B':3.0, 'B-':2.66, 'C+':2.33, 'C':2.0, 'C-':1.66, 'D+':1.33, 'D':1.00, 'D-':.66, 'F':0.00}
# Create a program, gpacalc.py, that takes four letter grade arguments and prints out the corresponding GPA, to two decimals.  
# Your program should accept both upper-case and lower-case arguments. Your program should print in the form: 'My GPA is x', where x is the calculated GPA.

import sys

def gpacalc():
    gpa_dict = {'A':4.0, 'A-':3.66, 'B+':3.33, 'B':3.0, 'B-':2.66, 'C+':2.33, 'C':2.0, 'C-':1.66, 'D+':1.33, 'D':1.00, 'D-':.66, 'F':0.00}

    # Capitalize and index input grades
    grade1 = gpa_dict[sys.argv[1].upper()]
    grade2 = gpa_dict[sys.argv[2].upper()]
    grade3 = gpa_dict[sys.argv[3].upper()]
    grade4 = gpa_dict[sys.argv[4].upper()]

    # Calculate average grade
    ave_gpa = (grade1 + grade2 + grade3 + grade4) / 4

    # Printing a string to include ':.2f' ensures a trailing zero won't be omitted
    print(f'My GPA is {ave_gpa:.2f}')

gpacalc()
