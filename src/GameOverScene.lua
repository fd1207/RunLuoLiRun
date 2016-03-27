
GameOverScene = class("GameOverScene", function(...)
	return cc.Scene:create(...)
end)

function GameOverScene:onEnter()
	local gameOverLayer = cc.Layer:create()
	local backgroundSprite = cc.Sprite:create("gameover.png")
	backgroundSprite:setPosition(cc.p(size.width / 2, size.height / 2))
	self:addChild(backgroundSprite)
	local gameOverImageSize = backgroundSprite:getContentSize()
	--print(gameOverImageSize.width, gameOverImageSize.height)

	local backMenuItem = cc.MenuItemImage:create("back.png", "back.png")
	local function backItemCallback()
		director:popScene()
	end
	backMenuItem:registerScriptTapHandler(backItemCallback)
	local backMenu = cc.Menu:create(backMenuItem)
	backMenu:setPosition(cc.p(size.width / 2, size.height / 4))
	self:addChild(backMenu)
end

function GameOverScene:create()
	local gameOverScene = GameOverScene.new()
	gameOverScene:onEnter()

	return gameOverScene
end