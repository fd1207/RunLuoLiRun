
GameObjStar = class("GameObjStar", function (...)
	return cc.Sprite:create(...)
end)

GameObjStar.visible = true

function GameObjStar:create()
	local starSprite = GameObjStar.new("star.png")
	starSprite:setContentSize(cc.size(73, 71))
	
	return starSprite
end