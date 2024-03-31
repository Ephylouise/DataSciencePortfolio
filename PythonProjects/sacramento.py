# Use the sacramento.csv file to complete the following assignment. Create a file, sacramento.py, that loads the .csv file and 
# runs a logistic regression. The regression should predict whether or not a house has 1 or more than one bathroom based on beds, sqft, and price, in that order.
# You will need to create a new variable from baths, and it should make it such that those observations of 1 bath correspond to a value of 0, and those with more than 1 bath correspond to a 1. 
# Make sure to add a constant using sm.add_constant(X) Your file should print the results in this way:
# print(mod.params.round(2))
# print(mod.pvalues.round(2))
# print('The smallest p-value is for sqft')

import numpy as np
import pandas as pd
import statsmodels.api as sm

# Read in CSV file
homes = pd.read_csv('sacramento.csv')

# Create binary/dummy variable for baths
homes['baths2'] = np.select([(homes['baths'] == 1), homes['baths'] != 1], [0, 1])

# Assign independent (exogenous) object with added constant
x = sm.add_constant(homes.loc[:, ['beds', 'sqft', 'price']], prepend=True)

# Assign dependent (endogenous) variable to an object
y = homes.baths2

# Run linear regression, fit, and summarize the model
bath_mod = sm.Logit(y, x).fit()     
bath_mod.summary()

# Order p-values from smallest to largest
ordered_pvalues = bath_mod.pvalues.sort_values()

# Find the smallest p-value excluding the added constant
min_pvalue = bath_mod.pvalues.drop('const').min()

# Find the variable with the smallest p-value
min_pvalue_var = bath_mod.pvalues.drop('const').idxmin()

# Print the parameters and p-values
print(bath_mod.params.round(2))
print(bath_mod.pvalues.round(2))
print(f'The smallest p-value is for {min_pvalue_var}')
