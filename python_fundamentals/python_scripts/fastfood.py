# Use the fastfood.csv file to complete the following assignment. Create a file, fastfood.py, that loads the .csv file and 
# runs a regression predicting calories from total_fat, sat_fat, cholesterol, and sodium, in that order. 
# Add a constant using sm.add_constant(data). Note: you will not need to upload the .csv to CodeGrade because I have pre-loaded it. Then, print the following to two decimals
# print(model.mse_total.round(2))
# print(model.rsquared.round(2))
# print(model.params.round(2))
# print(model.pvalues.round(2))

import sys
import pandas as pd
import statsmodels.api as sm

# Read in CSV file
fastfood = pd.read_csv('fastfood.csv')

# Assign a subset df using '.loc[]' to select all rows for desired columns to independent (exogenous) object
x = fastfood.loc[:, ['total_fat', 'sat_fat', 'cholesterol', 'sodium']]

# Add a constant to independent object (adds a column of 1's to start of df)
x = sm.add_constant(x, prepend = True)

# Assign dependent (endogenous) variable to an object
y = fastfood.calories

# Run linear regression, fit, and summarize the model
cal_mod = sm.OLS(y, x).fit()     
cal_mod.summary()

# Print the desired stats
print(cal_mod.mse_total.round(2))
print(cal_mod.rsquared.round(2))
print(cal_mod.params.round(2))
print(cal_mod.pvalues.round(2))
