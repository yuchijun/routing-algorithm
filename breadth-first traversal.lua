Links = GetControl("links.shp")
marked = {}

function GetNextAdj(v)						--获得下一个邻接点
for i = 1, GetRecCount(Links) do
		local o = GetValue(Links, "O", i)
		local d = GetValue(Links, "D", i)
		if o==v and not marked[d] then
			return d
		elseif d==v and not marked[o] then
			return o
		end
	end
	

end

function BreadthFirstSearch(v)
	local tovisit = {v}						--设置待访问列表
	local cur = 1								--设置当前访问指针
	while tovisit[cur] do
		 v=tovisit[cur]								--设置当前节点
                                            
         print(v)                                       --访问并打印
        w=GetNextAdj(v)							--获得邻接点
		while w do								--如果邻接点有效
			marked[w]=true									--标记防止重复
			table.insert(tovisit, w)			--插入到待访问列表
			w=GetNextAdj(v)								--获得邻接点
		end
		cur = cur + 1							--设置访问指针
	end
end

marked[2] = true
BreadthFirstSearch(2)