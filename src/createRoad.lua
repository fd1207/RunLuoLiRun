
GameObjMap = GameObjMap or {}

function GameObjMap:createRoad(bgSpr, bgEleTab)
	--print(#bgEleTab)
	for i = 1, #bgEleTab do
		if bgEleTab[i] == -1 then  -- Empty
			local trapSprite = GameObjTrap:create()
			local startPosition = cc.p(128 * (i - 1), 90)
			local endPosition  = cc.p(128 * i, 90)
			trapSprite.startPosition = startPosition
			trapSprite.endPosition   = endPosition
			trapSprite:setPosition(64 + 128 * (i - 1), 90)
			trapSprite:setVisible(false)
			emptyTrap[#emptyTrap + 1] = trapSprite
			bgSpr:addChild(trapSprite)
		elseif bgEleTab[i] == 0 then  -- Tree
			local treeSpr = cc.Sprite:create("back_2.png")
			treeSpr:setAnchorPoint(cc.p(0.5, 0))
			treeSpr:setPosition(cc.p(64 + 128 * (i - 1), 90))
			bgSpr:addChild(treeSpr, 2)
			if bgEleTab[i-1] == -1 or bgEleTab[i-1] == 3 then  -- 处理边界情况
				local roadSpr = cc.Sprite:create("road_1.png")
				roadSpr:setAnchorPoint(cc.p(0.5, 1))
				roadSpr:setPosition(cc.p(74 + 128 * (i - 1), 116))
				bgSpr:addChild(roadSpr, 1)
				local roaddiSpr = cc.Sprite:create("road_4.png")
				roaddiSpr:setAnchorPoint(cc.p(0.5, 1))
				roaddiSpr:setPosition(cc.p(74 + 128 * (i - 1), -10))
				bgSpr:addChild(roaddiSpr, 1)
			elseif bgEleTab[i+1] == -1 or bgEleTab[i+1] == 3 then
				local roadSpr = cc.Sprite:create("road_1.png")
				roadSpr:setAnchorPoint(cc.p(0.5, 1))
				roadSpr:runAction(cc.FlipX:create(true))
				roadSpr:setPosition(cc.p(54 + 128 * (i - 1), 116))
				bgSpr:addChild(roadSpr, 1)
				local roaddiSpr = cc.Sprite:create("road_4.png")
				roaddiSpr:setAnchorPoint(cc.p(0.5, 1))
				roaddiSpr:runAction(cc.FlipX:create(true))
				roaddiSpr:setPosition(cc.p(54 + 128 * (i - 1), -10))
				bgSpr:addChild(roaddiSpr, 1)	
			else 
				local roadSpr = cc.Sprite:create("road_2.png")
				roadSpr:setAnchorPoint(cc.p(0.5, 1))
				roadSpr:setPosition(cc.p(64 + 128 * (i - 1), 116))
				bgSpr:addChild(roadSpr, 1)
				local roaddiSpr = cc.Sprite:create("road_3.png")
				roaddiSpr:setAnchorPoint(cc.p(0.5, 1))
				roaddiSpr:setPosition(cc.p(64 + 128 * (i - 1), -10))
				bgSpr:addChild(roaddiSpr, 1)
			end
		elseif bgEleTab[i] == 1 then  -- Left Edge
			local roadSpr = cc.Sprite:create("road_1.png")
			roadSpr:setAnchorPoint(cc.p(0.5, 1))
			roadSpr:setPosition(cc.p(74 + 128 * (i - 1), 116))
			bgSpr:addChild(roadSpr, 1)
			local roaddiSpr = cc.Sprite:create("road_4.png")
			roaddiSpr:setAnchorPoint(cc.p(0.5, 1))
			roaddiSpr:setPosition(cc.p(74 + 128 * (i - 1), -10))
			bgSpr:addChild(roaddiSpr, 1)
		elseif bgEleTab[i] == 2 then  -- Enemy
			local enemySpr = GameObjEnemy:create()
			enemySpr:setAnchorPoint(cc.p(0.5, 0.5))
			enemySpr:setPosition(cc.p(64 + 128 * (i - 1), 144))
			bgSpr:addChild(enemySpr, 3)
			enemys[#enemys + 1] = enemySpr

			if bgEleTab[i-1] == -1 or bgEleTab[i-1] == 3 then  -- 处理边界情况
				local roadSpr = cc.Sprite:create("road_1.png")
				roadSpr:setAnchorPoint(cc.p(0.5, 1))
				roadSpr:setPosition(cc.p(74 + 128 * (i - 1), 116))
				bgSpr:addChild(roadSpr, 1)
				local roaddiSpr = cc.Sprite:create("road_4.png")
				roaddiSpr:setAnchorPoint(cc.p(0.5, 1))
				roaddiSpr:setPosition(cc.p(74 + 128 * (i - 1), -10))
				bgSpr:addChild(roaddiSpr, 1)
			elseif bgEleTab[i+1] == -1 or bgEleTab[i+1] == 3 then
				local roadSpr = cc.Sprite:create("road_1.png")
				roadSpr:setAnchorPoint(cc.p(0.5, 1))
				roadSpr:runAction(cc.FlipX:create(true))
				roadSpr:setPosition(cc.p(54 + 128 * (i - 1), 116))
				bgSpr:addChild(roadSpr, 1)
				local roaddiSpr = cc.Sprite:create("road_4.png")				
				roaddiSpr:setAnchorPoint(cc.p(0.5, 1))
				roaddiSpr:runAction(cc.FlipX:create(true))
				roaddiSpr:setPosition(cc.p(54 + 128 * (i - 1), -10))
				bgSpr:addChild(roaddiSpr, 1)	
			else 
				local roadSpr = cc.Sprite:create("road_2.png")
				roadSpr:setAnchorPoint(cc.p(0.5, 1))
				roadSpr:setPosition(cc.p(64 + 128 * (i - 1), 116))
				bgSpr:addChild(roadSpr, 1)
				local roaddiSpr = cc.Sprite:create("road_3.png")
				roaddiSpr:setAnchorPoint(cc.p(0.5, 1))
				roaddiSpr:setPosition(cc.p(64 + 128 * (i - 1), -10))
				bgSpr:addChild(roaddiSpr, 1)
			end
		elseif bgEleTab[i] == 3 then -- Floated Lend
			local floatSpr = cc.Sprite:create("road_5.png")
			floatSpr:setAnchorPoint(cc.p(0.5, 1))
			floatSpr:setPosition(cc.p(64 + 128 * (i - 1), 116))
			bgSpr:addChild(floatSpr, 2)
		elseif bgEleTab[i] == 4 then  -- Right Edge
			local roadSpr = cc.Sprite:create("road_1.png")
			roadSpr:setAnchorPoint(cc.p(0.5, 1))
			roadSpr:runAction(cc.FlipX:create(true))
			roadSpr:setPosition(cc.p(54 + 128 * (i - 1), 116))
			bgSpr:addChild(roadSpr, 1)
			local roaddiSpr = cc.Sprite:create("road_4.png")
			roaddiSpr:setAnchorPoint(cc.p(0.5, 1))
			roaddiSpr:runAction(cc.FlipX:create(true))
			roaddiSpr:setPosition(cc.p(54 + 128 * (i - 1), -10))
			bgSpr:addChild(roaddiSpr, 1)
		end
	end
end