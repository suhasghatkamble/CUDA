import numpy as np

# Part 1
def roll_dice():
    # Simulation of rolling a dice twice, minimum number we get is 1, max is 6
    # Add the results of the two simulations, so possible values will be:
    # (1, 1) or (1, 2) ... (6, 6) ... Sum will be between 2 --> (1,1) and 12 --> (6, 6)
    # Run multiple times to verify 
    return np.sum(np.random.randint(1, 7, 2))

print(roll_dice())

#3, 11, 5