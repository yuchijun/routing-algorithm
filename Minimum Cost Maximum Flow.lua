links=GetControl("lines.shp")
nodes=GetControl("nodes.shp")
lp=CreateLP()
numd=GetRecCount(nodes)
numx=GetRecCount(links)
f=5
c={}
u={}
dianliu={}

for i=1,numx do
    c[i]=GetValue(links,"C",i)
end
SetObjFunction(lp,c,"min")
xian={}
liu={}
for i = 1, numx do
    for j = 1, numx do
        if i==j then
            liu[j] = 1
        else
            liu[j] = 0
        end
    end
    AddConstraint(lp, liu, "<=",GetValue(links, "U", i))
end
AddConstraint(lp,{0,0,0,0,0,1},"=",f)

for i=1,numd do
    for j=1,numx do
        local o = GetValue(links, "O", j)
		local d = GetValue(links, "D", j)
        if i==o then
            xian[j]=1
        elseif i==d then
            xian[j]=-1
        else
            xian[j]=0
        end
       end
    
  AddConstraint(lp,xian, "=", 0)
end
SolveLP(lp)

Print("1到4","流量为",f,"的最小费用是",GetObjective(lp))
WriteLP(lp, "sample.mps")
WriteLP(lp, "sample.lp")
 