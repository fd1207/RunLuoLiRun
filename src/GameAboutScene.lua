
local GameAboutScene = class("GameAboutScene", function()
	cc.Scene:create()
end)

function GameAboutScene:create()
	local scene = cc.Scene:create()
	local layer = GameAboutScene:createAboutLayer()
	layer:setPosition(cc.p(0, 0))
	scene:addChild(layer)

	local function onEnter()
		print "GameAboutScene:onEnter()"
		local label = layer:getChildByTag(2)
		local title = layer:getChildByTag(3)
		title:setScale(0)
		label:setScale(0.5)
		local act1 = cc.ScaleTo:create(0.5, 1.1)
		local act2 = cc.ScaleTo:create(0.2, 1)
		local seq  = cc.Sequence:create(act1, act2)
		label:runAction(seq)
		local act3 = cc.ScaleTo:create(0.5, 1.2)
		local act4 = cc.ScaleTo:create(0.2, 1)
		local seq1 = cc.Sequence:create(act3, act4)
		title:runAction(seq1)
	end

	local function onExit()
		print("GameAboutScene:onExit()")
	end

	local function onNodeEvent(event)
		if event == "enter" then
			onEnter()
		elseif event == "exit" then
			onExit()
		end
	end

	scene:registerScriptHandler(onNodeEvent)

	return scene
end

function GameAboutScene:createAboutLayer()
	local layer = cc.Layer:create()
	local bg = cc.Sprite:create("back_1.png")
	bg:setScale(1.3)
	bg:setPosition(cc.p(size.width / 2, size.height / 2))
	layer:addChild(bg, 0)

	-- Add Frame
	local kuang = cc.Sprite:create("tb.png")
	kuang:setRotation(90)
	kuang:setPosition(cc.p(size.width / 2, size.height / 2))
	layer:addChild(kuang, 1)

	-- Add Label
	local aboutLabel = cc.LabelTTF:create("Name: loli run\n\nProgram:YuHuai\n\nArt design:zuyi li\n\nSchool:USTC\n\nTime: 2016/02",
		"Marker Felt", 40)
	--aboutLabel:setAnchorPoint(cc.p(0, 0))
	aboutLabel:setPosition(cc.p(size.width / 2, size.height / 2))
	aboutLabel:setColor(cc.c3b(0, 0, 0))
	layer:addChild(aboutLabel, 2, 2)

	-- Add Title
	local aboutTitle = cc.Sprite:create("about.png")
	--aboutTitle:setScale(0.5)
	aboutTitle:setPosition(size.width / 2, size.height - 80)
	layer:addChild(aboutTitle, 2, 3)

	-- Add Back Image
	local backImage = cc.MenuItemImage:create("backB.png", "backA.png")
	backImage:setPosition(cc.p(size.width - 40,size.height - 40))
	local function backImageCallback()
		print("backImageCallback")
		director:popScene()
	end
	backImage:registerScriptTapHandler(backImageCallback)
	local mn = cc.Menu:create(backImage)
	mn:setPosition(cc.p(0, 0))
	layer:addChild(mn)

	return layer
end

return GameAboutScene