road=GetControl("road.shp")
node=GetControl("node.shp")
numd=GetRecCount(node)
startid=0
sr={}
s={}
R=50
for i=1,numd do
sr[i]={}
end
for i=1,numd do
sr[i][1]=0
sr[i][2]=i
sr[i][3]=0
end
for roadid=1,6 do
s[roadid]=0
end
marked={}
for i=1,6 do
    marked[i]=false
end
peis=0
he={}
t=0
while peis<=50 do
for roadid=7,12 do
    if marked[roadid-6]==false then
     s[roadid]=GetValue(road,"DIS",roadid-6)+GetValue(road,"DIS",roadid-6+1)-GetValue(road,"DIS",roadid)
 else 
     s[roadid]=0
    end
    
end
big={}
big=math.max(unpack(s))
for i=1,6 do
local o=GetValue(road,"O",i+6)
local d=GetValue(road,"D",i+6)
if s[i+6]==big then
    t=t+1
    he[t]={}
for j=1,3 do
he[t][j]=sr[i][j]
end
for k=4,6 do
he[t][k]=sr[i+1][k-3]
end
if marked[i-1]==true then
      peis=peis+GetValue(node,"DEMAND",i+1)
  else
     peis=peis+GetValue(node,"DEMAND",i)+GetValue(node,"DEMAND",i+1)
     end
marked[i]=true

end
end
end
helu={}
zhen=0
for i=1,t do
    for j=1,6 do
        if he[i][j]~=0 then
        zhen=zhen+1
        helu[zhen]=he[i][j]
        end
    end
end
zhelu={}
zhelu[1]=0
zhen2=1
for i=1,#helu do
    if helu[i]~=helu[i+1] then
        zhen2=zhen2+1
        zhelu[zhen2]=helu[i]
    end
end
table.sort(zhelu)
for i=1,#zhelu do
    if zhelu[i]~=zhelu[i+1] then
        print(zhelu[i])
end
end
print(0)
        