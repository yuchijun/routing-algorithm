Links=GetControl("links.shp")
nodes=GetControl("notes.shp")
lp=CreateLP()
numd=GetRecCount(nodes)
numx=GetRecCount(Links)
dis={}
sid=15
eid=2
for i=1,numx do
    dis[i]=GetValue(Links,"DIS",i)
end
for i=1,numx do
    dis[numx+i]=GetValue(Links,"DIS",i)
end
SetObjFunction(lp,dis,"min")
xian={}
for i=1,numd do
    for j=1,numx do
        local o = GetValue(Links, "O", j)
		local d = GetValue(Links, "D", j)
        if i==o then
            xian[j]=1
        elseif i==d then
            xian[j]=-1
        else
            xian[j]=0
        end
    end
    for j=1,numx do
        local o = GetValue(Links, "O", j)
		local d = GetValue(Links, "D", j)
        if i==o then
            xian[numx+j]=-1
        elseif i==d then
            xian[numx+j]=1
        else
            xian[numx+j]=0
        end
    end
    if i==sid then
        AddConstraint(lp, xian, "=", 1)
    elseif i==eid then
          AddConstraint(lp, xian, "=", -1)
      else 
          AddConstraint(lp, xian, "=", 0)
      end
  end
  for i=1,2*numx do
    SetBinary(lp,i)
end
SolveLP(lp)
for i=1,numx do
    if GetVariable(lp,i)~=0 then
        Print(GetValue(Links, "D", i))
    end
    
    if GetVariable(lp,numx+i)~=0 then
        Print(GetValue(Links, "O", i))
    end
end
Print(sid,"到",eid,"最短距离是",GetObjective(lp))
        
            
            
            
            
            
            