local demand=GetControl("demand.shp")
local dis=GetControl("dis.shp")
local supply=GetControl("supply.shp")
lp=CreateLP()
numxu=GetRecCount(demand)
numsup=GetRecCount(supply)
bd={}
p=1
for i=1,4 do
    bd[i]=GetValue(demand,"QA",1)*GetValue(dis,"DIS",i)
end
for i=5,8 do
    bd[i]=GetValue(demand,"QA",2)*GetValue(dis,"DIS",i)
end
for i=9,12 do
    bd[i]=GetValue(demand,"QA",3)*GetValue(dis,"DIS",i)
end
for i=13,16 do
    bd[i]=0
    end
SetObjFunction(lp,bd,"min")
a1={}
for i=1,4 do
    a1[i]=1
    SetBinary(lp,i)
end
 AddConstraint(lp,a1,"=",1)
 a2={}
 for i=5,8 do
    a2[i]=1
    SetBinary(lp,i)
end
 AddConstraint(lp,a2,"=",1)
 a3={}
 for i=9,12 do
    a3[i]=1
    SetBinary(lp,i)
end
 AddConstraint(lp,a3,"=",1)
 
 b={}
 for i=13,16 do
     b[i]=1
     SetBinary(lp,i)
 end
 AddConstraint(lp,b,"<=",p)
w={}
for i=1,16 do
    w[i]=0
end
t=-3
for j=1,3 do
w[13]=1
t=t+4
w[t]=-1
AddConstraint(lp,w,">=",0)
for k=1,16 do
    w[k]=0
end
end
t=-2
for j=1,3 do
w[14]=1
t=t+4
w[t]=-1
AddConstraint(lp,w,">=",0)
for k=1,16 do
    w[k]=0
end
end
t=-1
for j=1,3 do
w[15]=1
t=t+4
w[t]=-1
AddConstraint(lp,w,">=",0)
for k=1,16 do
    w[k]=0
end
end
t=0
for j=1,3 do
w[16]=1
t=t+4
w[t]=-1
AddConstraint(lp,w,">=",0)
for k=1,16 do
    w[k]=0
end
end

SolveLP(lp)
Print("最小费用是",GetObjective(lp))
for i=1,4 do
    if GetVariable(lp,i)~=0 then
        Print("站点",i,"服务于点1")
    end
end
for i=5,8 do
    if GetVariable(lp,i)~=0 then
        Print("站点",i-4,"服务于点2")
    end
end
for i=9,12 do
    if GetVariable(lp,i)~=0 then
        Print("站点",i-8,"服务于点3")
    end
end

WriteLP(lp, "sample.mps")
WriteLP(lp, "sample.lp")
    