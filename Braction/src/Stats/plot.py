import matplotlib.pyplot as plt
import numpy as np
import sys

# make sure this doesn't handle empty case, handle in JAva
# handle case of less than 5

# get ID from command line and
userID = sys.argv[1]
file = open(userID + ".txt", "r")

# process file, split it, then create boundaries
yee = file.read()

eloStrList = yee.split("\n")

data = np.arange(len(eloStrList))  # list of all games

eloList = list()

#

for strNum in eloStrList:
    eloList.append(int(strNum))

fig = plt.figure()
ax = fig.add_subplot(1,1,1)

ax.set_title('ELO over time (games played)')

ax.plot(data, eloList, 'k-')
ax.set_xlabel('Games Played')
ax.set_ylabel('Elo')

plt.savefig('all'+str(userID)+'.png', dpi=400, bbox_inches='tight')


if(len(eloStrList) >=20):  # make sure full graph displays without negative indices
    ax.set_xlim([len(eloStrList)-20, len(eloStrList)-1])

ax.set_title('ELO over past 20 games')
ax.set_xlabel('Games Range')
plt.savefig('twenty'+str(userID)+'.png', dpi=400, bbox_inches='tight')

ax.set_title('ELO over past 5 games')
if(len(eloStrList) >= 5):
    ax.set_xlim([len(eloStrList)-5, len(eloStrList)-1])
plt.savefig('five'+str(userID)+'.png', dpi=400, bbox_inches='tight')

print("Success")
