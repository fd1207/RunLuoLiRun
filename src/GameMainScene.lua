
GameMainScene = class("GameMainScene", function(...)
	return cc.Scene:create(...)
end)

local scoreLayerTag = 0
local heroPositionY = 320
local heroHeight = 250
local heroWidth  = 200
local widthUnit = 128

function GameMainScene.getStar(self)
	local heroWidth, heroHeight = self:getPosition()
	local hreoPosition = cc.p(heroWidth, heroHeight)
	hreoPosition = self:getParent():convertToWorldSpace(hreoPosition)
	for i = 1, #stars1 do
		local starWidth, starHeight = stars1[i]:getPosition()
		local starPosition = cc.p(starWidth, starHeight)
		starPosition = stars1[i]:getParent():convertToWorldSpace(starPosition)
		local widthDiff = hreoPosition.x - starPosition.x
		local heightDiff = hreoPosition.y - starPosition.y
		if stars1[i].visible == true and 
			widthDiff*widthDiff + heightDiff*heightDiff < 10000 then
			stars1[i].visible = false
			stars1[i]:setVisible(false)
			score = score + 1
			local scoreLayer = self:getParent():getParent():getChildByTag(scoreLayerTag)
			scoreLayer:setScore(score)
		end
	end
	for i = 1, #stars2 do
		local starWidth, starHeight = stars2[i]:getPosition()
		local starPosition = cc.p(starWidth, starHeight)
		starPosition = stars2[i]:getParent():convertToWorldSpace(starPosition)
		local widthDiff = hreoPosition.x - starPosition.x
		local heightDiff = hreoPosition.y - starPosition.y
		if stars2[i].visible == true and 
			widthDiff*widthDiff + heightDiff*heightDiff < 10000 then
			stars2[i].visible = false
			stars2[i]:setVisible(false)
			score = score + 1
			local scoreLayer = self:getParent():getParent():getChildByTag(scoreLayerTag)
			scoreLayer:setScore(score)
			--print("score", score)
		end
	end
end

function GameMainScene.isHurted(self)
	local heroWidth, heroHeight = self:getPosition()
	local hreoPosition = cc.p(heroWidth, heroHeight)
	hreoPosition = self:getParent():convertToWorldSpace(hreoPosition)
	-- print("hreoPosition:" , hreoPosition.x, hreoPosition.y)
	for i = 1, #enemys do
		local emenyWidth, enemyHeight = enemys[i]:getPosition()
		local enemyPosition = cc.p(emenyWidth, enemyHeight)
		enemyPosition = enemys[i]:getParent():convertToWorldSpace(enemyPosition)
		-- print("enemyPosition:", enemyPosition.x, enemyPosition.y)
		--print(mapLayer == enemys[i]:getParent())
		local widthDiff = hreoPosition.x - enemyPosition.x
		local heightDiff = hreoPosition.y - enemyPosition.y
		if self.hurtable == true and 
			widthDiff*widthDiff + heightDiff*heightDiff < 10000 then
			--print("self:hurted()")
			self:hurted()		
		end
	end
end

function GameMainScene:dropped()
	local heroWidth, heroHeight = self:getPosition()
	local heroPosition = cc.p(heroWidth, heroHeight)
	heroPosition = self:getParent():convertToWorldSpace(heroPosition)
	for i = 1, #emptyTrap do
		local middlePositionX, middlePositionY = emptyTrap[i]:getPosition()
		local startPosition = emptyTrap[i]:getParent():convertToWorldSpace(
			cc.p(middlePositionX - widthUnit / 2, middlePositionY))
		local endPosition = emptyTrap[i]:getParent():convertToWorldSpace(
			cc.p(middlePositionX + widthUnit / 2, middlePositionY))
		if heroPosition.y == heroPositionY and
			heroPosition.x > startPosition.x and
			heroPosition.x < endPosition.x then
			self:drop()
		end
	end
end

function GameMainScene:create()
	local mainScene = GameMainScene.new()

	local heroLayer = cc.Layer:create()
	local hero  = GameObjHero:create()
	hero:setPosition(cc.p(size.width / 4, heroPositionY))
	hero:touchListener(heroLayer)
	heroLayer:addChild(hero)
	mainScene:addChild(heroLayer, 1)

	local mapLayer = GameObjMap:create()
	mainScene:addChild(mapLayer, 0)
	schedule(hero, GameMainScene.getStar, 0.3)
	schedule(hero, GameMainScene.isHurted, 0.3)
	schedule(hero, GameMainScene.dropped, 0.05)

	local scoreLayer = GameObjScore:create()
	mainScene:addChild(scoreLayer, 1, scoreLayerTag)

	return mainScene
end