
GameObjScore = class("GameObjScore", function(...)
	return cc.Layer:create(...)
end)

local scoreTexture
local scoreSprite
local scoreLength = 4

function GameObjScore:onEnter()
	local visibleSize  = director:getVisibleSize()
	scoreSprite  = cc.Sprite:create("score.png")
	local socreNum     = cc.Sprite:create("shu.png")
	scoreTexture = socreNum:getTexture()
	scoreSprite:setAnchorPoint(cc.p(1, 1))
	scoreSprite:setPosition(cc.p(visibleSize.width - 200, visibleSize.height - 20))
	-- 初始化得分
	for i = 1, scoreLength do
		local digSprite = cc.Sprite:createWithTexture(scoreTexture, cc.rect(235, 0, 26, 31))
		digSprite:setAnchorPoint(cc.p(0, 0))
		digSprite:setPosition(cc.p(108 + 30*(i - 1), 0))
		scoreSprite:addChild(digSprite, 1, i)
	end
	self:addChild(scoreSprite)
end

function GameObjScore:setScore(value)
	local valueTmp = value
	for i = 1, scoreLength do
		local dig, _ = math.modf(valueTmp / math.pow(10, scoreLength - i))
		valueTmp  = valueTmp % math.pow(10, scoreLength - i)
		local numSprite = scoreSprite:getChildByTag(i)
		if dig == 0 then
			numSprite:setTexture(scoreTexture)
			numSprite:setTextureRect(cc.rect(235, 0, 26, 31))
		else
			numSprite:setTexture(scoreTexture)
			numSprite:setTextureRect(cc.rect(26*(dig - 1) + 1, 0, 26, 31))
		end
	end
end

function GameObjScore:create()
	local scoreLayer = GameObjScore.new()
	scoreLayer:onEnter()
	return scoreLayer
end