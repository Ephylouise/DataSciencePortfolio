# For this assignment, use the president_heights.csv file found in the Brightspace module. You WILL NOT NEED TO SUBMIT THE FILE TO CODEGRADE 
# Create a program, presidents.py, that takes two arguments. These arguments will correspond to the start and stop of a slice, respectively. 
# It will slice the heights column in the president_heights.csv files.
# Then print off the average height, rounded to two decimals, of the selected presidents in the following form:
# The average height of presidents number x to y is z

import sys
import pandas as pd

# Read in CSV file, assign column name to object, and inputs to int-type objects
pres_df = pd.read_csv('president_heights.csv')
column_name = 'height(cm)'
start, stop = int(sys.argv[1]), int(sys.argv[2])

# Slice df at for the 'heights' column
sliced_df = pres_df[column_name].iloc[start:stop]

# Find the average of sliced heights
average_height = sliced_df.mean()

print(f'The average height of presidents number {start} to {stop} is {average_height:.2f}')
