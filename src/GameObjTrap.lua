
GameObjTrap = class("GameObjTrap", function(...)
	return cc.Sprite:create(...)
end)

GameObjTrap.startPosition = nil
GameObjTrap.endtPosition  = nil

function GameObjTrap:create()
	local trapSprite = GameObjTrap.new()
	trapSprite:setContentSize(cc.size(1, 1))

	return trapSprite
end