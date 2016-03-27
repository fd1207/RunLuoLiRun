
GameObjMap = class("GameObjMap", function () 
	return cc.Layer:create()
end)

require "createRoad"

local bgEle1 = {-1,1,0,4,-1,1,2,4}; --背景图素块编号
local bgEle2 = {-1,0,2,4,3,-1,1,4};

local function bg1Change(self)
	print "GameObjMap:bg1Change"
	local mapLayer = self:getParent()
	local bg = mapLayer:getChildByTag(1)
	bg:setPosition(cc.p(1016, 640))
	-- 重置所有星星状态
	for i = 1, #stars1 do
		stars1[i]:setVisible(true)
		stars1[i].visible = true
	end
	bg:runAction(cc.Sequence:create(cc.MoveBy:create(18, cc.p(-2040, 0)), 
		cc.CallFunc:create(bg1Change)))
end

local function bg2Change(self)
	print "GameObjMap:bg2Change"
	local mapLayer = self:getParent()
	local bg = mapLayer:getChildByTag(2)
	bg:setPosition(cc.p(1016, 640))
	-- 重置所有星星状态
	for i = 1, #stars2 do
		stars2[i]:setVisible(true)
		stars2[i].visible = true
	end
	bg:runAction(cc.Sequence:create(cc.MoveBy:create(18, cc.p(-2040, 0)), 
		cc.CallFunc:create(bg2Change)))
end

function GameObjMap:onEnter()
	--self:setContentSize(size)
	-- background
	bg1 = cc.Sprite:create("back_1.png")
	--bg1:setContentSize(size)
	bg1:setAnchorPoint(cc.p(0, 1))
	bg1:setPosition(cc.p(0, size.height))
	local bgdi1 = cc.Sprite:create("back_5.png")
	--bg1:setContentSize(size)
	bgdi1:setAnchorPoint(cc.p(0, 0))
	bgdi1:setPosition(cc.p(0, -248))
	bg1:addChild(bgdi1, 1)
	self:addChild(bg1, 1, 1)
	

	bg2 = cc.Sprite:create("back_1.png")
	bg2:setAnchorPoint(cc.p(0, 1))
	bg2:setPosition(cc.p(1024, size.height))
	local bgdi2 = cc.Sprite:create("back_5.png")
	bgdi2:setAnchorPoint(cc.p(0, 0))
	bgdi2:setPosition(cc.p(0, -248))
	bg2:addChild(bgdi2, 1)
	self:addChild(bg2, 0, 2)
	
	bg1:runAction(cc.Sequence:create(cc.MoveBy:create(9, cc.p(-1024, 0)), 
		cc.CallFunc:create(bg1Change)))
	bg2:runAction(cc.Sequence:create(cc.MoveBy:create(18, cc.p(-2048, 0)), 
		cc.CallFunc:create(bg2Change)))

	-- Stars
	stars1 = {}
	stars2 = {}
	for i = 1, 5 do
		local starSprite1 = GameObjStar:create()
		starSprite1:setPosition(cc.p(172 + 192 * i,380))
		bg1:addChild(starSprite1, 3)
		stars1[i] = starSprite1

		local starSprite2 = GameObjStar:create()
		starSprite2:setPosition(cc.p(172 + 192 * i,380)) 
		bg2:addChild(starSprite2, 3)
		stars2[i] = starSprite2
	end

	-- Creat Road
	GameObjMap:createRoad(bg1, bgEle1)
	GameObjMap:createRoad(bg2, bgEle2)
end

function GameObjMap:create()
	mapLayer = GameObjMap.new()
	mapLayer:onEnter()	
	local sp = cc.Sprite:create("s_1.png")
	sp:setAnchorPoint(cc.p(0.5, 1))
	sp:runAction(cc.FlipX:create(true))
	sp:setPosition(cc.p(400, 400))
	--mapLayer:addChild(sp, 100)
	return mapLayer
end