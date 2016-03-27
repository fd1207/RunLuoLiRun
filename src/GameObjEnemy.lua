
GameObjEnemy = class("GameObjEnemy", function(...)
	return cc.Sprite:create(...)
end)

function GameObjEnemy:onEnter()
	self:setAnchorPoint(cc.p(0.5, 0.5))
end

function GameObjEnemy:create()
	local enemySprite = GameObjEnemy.new("enemy.png")
	enemySprite:onEnter()

	return enemySprite
end