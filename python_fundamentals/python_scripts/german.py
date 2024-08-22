# Use the german_credit_data.csv file to complete the following assignment. Create a file, german.py, that loads the .csv file and 
# runs a regression predicting credit amount from age and duration, in that order. Add a constant using sm.add_constant(data). 
# You will need to rename the column 'Credit amount' and should change it to 'Credit_amount'. Note: you will not need to upload the .csv to CodeGrade because I have pre-loaded it. 
# Then, print the parameters and R-squared to 2 decimals using
# print(model.params.round(2)) print(model.rsquared.round(2))

import pandas as pd
import statsmodels.api as sm

# Read in CSV file
gcd = pd.read_csv('german_credit_data.csv')

# Rename columns to replace spaces with underscores
new_columns = []
for col in gcd.columns:
  new_column = col.replace(' ', '_')
  new_columns.append(new_column)
gcd.columns = new_columns

# Assign a subset df using '.loc[]' to select all rows for desired columns to independent (exogenous) object
x = gcd.loc[:, ['Age', 'Duration']]

# Add a constant to independent object (adds a column of 1's to start of df)
x = sm.add_constant(x, prepend = True)

# Assign dependent (endogenous) variable to an object
y = gcd.Credit_amount

# Run linear regression, fit, and summarize the model
credit_mod = sm.OLS(y, x).fit()     
credit_mod.summary()

# Print the parameters and R-squared to 2 decimals
print(credit_mod.params.round(2)) 
print(credit_mod.rsquared.round(2))
