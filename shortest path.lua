links=GetControl("links.shp")
nodes=GetControl("nodes.shp")
n=GetRecCount(nodes)
marked={}				--标记数组
stpdis={}					--最短距离
preid={}--前溯节点号
startid=GetValue(nodes,"ID",1)
endid=GetValue(nodes,"ID",n)
crtid = startid					--设置当前节点
for i=1,GetRecCount(nodes) do
    stpdis[i]=10000
    preid[i]=0
end
stpdis[1]=0

crtid=startid
while crtid ~= endid	do			--搜索直到终点
  for linkid = 1, GetRecCount(links) do 			
      local o=GetValue(links,"O",linkid)
      local d=GetValue(links,"D",linkid)--搜索所有链接
    if o == crtid then		--如果与当前节点邻接
      tmpid=d
      linkdis=GetValue(links,"DIS",linkid)
      if stpdis[crtid] + linkdis < stpdis[tmpid] then--并且另一端点的最短距离较大
        stpdis[tmpid] = stpdis[crtid] + linkdis
        preid[tmpid] = crtid		--修改另一端点的最短距离和前溯节点
      end
    end
  end

  crtid = endid					--设置下一个当前节点
  for nodeid = 1,n	 do 		--搜索所有节点
    if not marked[nodeid]		--找到未标记的有最小距离的节点
       and stpdis[nodeid] < stpdis[crtid] then
       crtid = nodeid				--重新设置当前节点
    end
  end
  marked[crtid] = true			--标记新的当前节点
end
a=n
while a>0 do
    print(a)
    a=preid[a]
    end
    
print(startid,"到",endid,"的最短距离是",stpdis[n])
