director = cc.Director:getInstance()
size     = director:getVisibleSize()  -- 在initGLView()之后才会产生正确的值
score = 0     -- 游戏得分
block = false
enemys = {}   -- 敌人Table
emptyTrap = {}  --[[地图中的空白陷阱
				emptyTrap[i][1] = startPosition
				emptyTrap[i][2] = endPosition
				--]]
stars1 = {}
stars2 = {}