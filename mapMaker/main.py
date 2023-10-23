from random import randrange, random
import matplotlib.pyplot as plt

class Station:
    def __init__(self, id:int, name:str, next=set([])):
        self.id = id
        self.name = name
        self.next = next


stations = {
    0: Station(id=0, name= 'Kennedy Town', next=set([(1, 2, 'E')])),
    1: Station(id=1, name= 'Cental', next=set([(2, 2, 'E')])),
    2: Station(id=2, name= 'North Point', next=set([(3, 2, 'E')])),
    3: Station(id=3, name= 'Chai Wan'),
    4: Station(id=4, name='Tsim Sha Tsui', next=set([(1, 0, 'SW')])),
    5: Station(id=5, name='Mong Kok', next=set([(4, 0, 'S')])),
    6: Station(id=6, name='Lai King', next=set([(5, 0, 'E'), (1, 3, 'S')])),
    7: Station(id=7, name='Choi Hung', next=set([(5, 1, 'W')])),
    8: Station(id=8, name='Kwun Tong', next=set([(7, 1, 'N')])),
    9: Station(id=9, name='Tsuen Wan', next=set([(6, 0, 'E')])),
    10: Station(id=10, name='Tung Chung', next=set([(6, 3, 'NE')])),
    11: Station(id=11, name='Yau Tong', next=set([(8, 1, 'N'), (2, 4, 'SW')])),
    12: Station(id=12, name='Po Lam', next=set([(11, 4, 'SW')]))
}

# supplement directions
oppositeDirection = {'N': 'S', 'NE': 'SW', 'E': 'W', 'SE': 'NW', 'S': 'N', 'SW': 'NE', 'W': 'E', 'NW': 'SE'}
for k, v in oppositeDirection.items(): oppositeDirection[v] = k
for id, station in stations.items():
    for nid, line, ndir in station.next: stations[nid].next.add((id, line, oppositeDirection[ndir]))
    

coord = {}
lineColors = {0: 'red', 1: 'green', 2: 'blue', 3: 'orange', 4:'purple'}
links = {i: set([]) for i in range(len(lineColors))}
directions = {'N': (0,1), 'NE': (.7,.7), 'E': (1,0), 'SE': (.7,-.7), 'S': (0,-1), 'SW': (-.7,-.7), 'W': (-1,0), 'NW': (-.7,.7)}

def dfs(station: Station):
    for nid, line, ndir in station.next:
        if nid < station.id: links[line].add((nid, station.id))
        else: links[line].add((station.id, nid))

        if nid in coord: continue
        coord[nid] = (
            coord[station.id][0] + directions[ndir][0] * (random()*0.2+1), 
            coord[station.id][1] + directions[ndir][1] * (random()*0.2+1)
        )
        dfs(stations[nid])

coord[0] = (0,0)
dfs(stations[0])

# for k,v in coord.items(): print(f"{k}: {v}")
# print(links)



for id,(x,y) in coord.items():
    plt.scatter(x, y, c='white', edgecolors='black', s=100, zorder=3)
    plt.text(x, y, stations[id].name, ha='right', va='bottom', fontsize=8)

for lid, arr in links.items():
    for fid, tid in arr:
        xf, yf = coord[fid][0], coord[fid][1]
        xt, yt = coord[tid][0], coord[tid][1]
        if abs(xt-xf) > abs(yt-yf):
            if xt > xf: xm, ym = xt-abs(yf-yt), yf
            else: xm, ym = xt+abs(yf-yt), yf
        else:
            if yt > yf: xm, ym = xf, yt-abs(xf-xt)
            else: xm, ym = xf, yt+abs(xf-xt)
        shift = random()*0.04-0.02
        xf, xm, xt, yf, ym, yt = xf+shift, xm+shift, xt+shift, yf+shift, ym+shift, yt+shift
        plt.plot([xf, xm, xt], [yf, ym, yt], color=lineColors[lid], linewidth=3)

plt.axis('off')
plt.show()