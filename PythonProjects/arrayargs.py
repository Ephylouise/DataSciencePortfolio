# Create a program called arrayargs.py that has a function that takes four integer arguments. 
# Those arguments should be put into an Numpy array. The function will have two print statements. 
# The first will print the type of the array you create (which should be <class ‘numpy.ndarray’>). 
# The second will print the multiplication of the four items in your array.
                                                                                                                                                                                                                                                   
import sys
import numpy as np

def arrayargs():
    # Create array and print the type to confirm
    arr = np.array([int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4])])
    print(type(arr))

    # Initialize the mutiplication result
    multiplied_arr = 1

    # For loop to multiply array integers
    for i in arr:
      multiplied_arr *= i
    print(multiplied_arr)

arrayargs()
