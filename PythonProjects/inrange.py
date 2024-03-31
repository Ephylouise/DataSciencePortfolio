# Create a program inrange.py that has a function that takes one integer argument. The function will print a 
# list of all values between 3000 and 5000 that is divisible by: the integer argument the integer argument + 7 the integer argument ^ 2
# For example, if the integer argument is 6, it should print: [3276, 3744, 4212, 4680]

import sys

def inrange(x):
    # Convert x to an integer
    x = int(x)
    
    # Initialize a list
    divisible_list = []

    # Set range of interest
    for num in range(3000, 5001):
        # Set divisibility arguments
        if num % x == 0 and num % (x+7) == 0 and num % (x**2) == 0:
            # Append divisible values to the list
            divisible_list.append(num)
    print(divisible_list)

inrange(sys.argv[1])
