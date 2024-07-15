import numpy as np

#part 1
def roll_dice():
  #Simulation of rolling a dice twice, minimum we get is 1, max is 6
  #Add the result of the two simulations , so possible values will be :
  # (1,1), (1,2), (2,3), (3,4), (4,5), (6,6)... sum will between 2 and 12
  #run multiple times to verif
  return np.sum(np.random.randint(1, 7, size=2))

print(roll_dice())



##Part 2
# someone approches us saying I will give you 5 dollers if you get 7 
# and take 1 doller if you get a number other than 7
# how do we know what will happen ?
# out won "Monte Carlo sumulation " like function *bold text*

def monte_carlo_simulation (runs=1000):
  results=np.zeros(2)  #AN array , results[0] and results[1] initialized to two zeroes
  for i in range(runs):
    if roll_dice()==7:
      results[0]+=1
    else:
      results[1]+=1
  return results

#Test 2-3 times and calculate how muzh you will win versus lose
print(monte_carlo_simulation())
print(monte_carlo_simulation())
print(monte_carlo_simulation())

#Results may be favourable to us , but was that by luck ?


# part 3: Now do it 100 times, Takes some time 
results=np.zeros(1000)

for i in range(1000):
  results[i]=monte_carlo_simulation()[0]

print(results)

#lets us plot it 
import matplotlib.pyplot as plt
fig,ax=plt.subplots()
ax.hist(results,bins=15)
plt.show()

#Our win / loss
print(results.mean())
print(results(mean()*5))    #General mean
print(results(mean()*4.75)) #Just a marginal change in win reaward see the impact
print(100 -results.mean())  #Just a margin change in win reward - see the impact
print(results.measn(1000)) #Probabiliyt of the we will win
#THe resulsl thow