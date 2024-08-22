# Create a program called randdf.py that has a function that takes two integer arguments and prints a Pandas dataframe. 
# The two arguments will correspond to the number of rows and number of columns, respectively. 
# The dataframe should be filled with random integers from 0 to 100. Set your random seed to 56.

import sys
import pandas as pd
import numpy as np

def randdf():
    # Set the seed for reproducibility
    np.random.seed(56)

    # Specify the desired number of rows and columns
    num_rows = int(sys.argv[1])
    num_columns = int(sys.argv[2])

    # Create df with random integers 0-100 of input size
    df = pd.DataFrame(np.random.randint(0, 100, size=(num_rows, num_columns)))

    print(df)

randdf()
