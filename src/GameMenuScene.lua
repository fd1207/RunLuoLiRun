
require "cocos.cocosdenshion.AudioEngine"

local GameMenuScene = class("GameMenuScene", function()
	return cc.Sprite:create()
end)

local MUSIC_FILE = "Super Mario Bros. - Ground Theme.mp3"
local MUSIC_FILE1  = "New Super Mario Bros. Wii - Title Theme.mp3" 

local function initGlobal()
	size     = director:getVisibleSize()  -- 在initGLView()之后才会产生正确的值
	score = 0     -- 游戏得分
	block = false
	enemys = {}   -- 敌人Table
	emptyTrap = {}  
	stars1 = {}
	stars2 = {}
end

function GameMenuScene:createLayer()

	local layer = cc.Layer:create()
	local bg = cc.Sprite:create("MainMenu.png")
	bg:setPosition(cc.p(size.width / 2, size.height / 2))
	layer:addChild(bg)

	-- Create Menu
	local mn = cc.Menu:create()
	mn:setPosition(cc.p(0, 0))
		-- New Game Item
	local newGameItem = cc.MenuItemImage:create("newgameA.png", "newgameB.png")
	newGameItem:setPosition(cc.p(size.width / 2 + 40, size.height / 2 + 20))
	local function newGameItemCallback()
		print("newGameItemCallback")
		initGlobal()
		local gameMainScene = GameMainScene:create()
		local tranScene  = cc.TransitionPageTurn:create(1, gameMainScene, false)
		director:pushScene(tranScene)
	end
	newGameItem:registerScriptTapHandler(newGameItemCallback)
	mn:addChild(newGameItem)

		-- Continue Item
	local continueItem = cc.MenuItemImage:create("continueA.png", "continueB.png")
	continueItem:setPosition(cc.p(size.width / 2 + 40, size.height / 2 - 40))
	local function continueItemCallback()
		print("continueItemCallback")
	end
	continueItem:registerScriptTapHandler(continueItemCallback)
	mn:addChild(continueItem)

		-- About Item
	local aboutItem = cc.MenuItemImage:create("aboutA.png", "aboutB.png")
	aboutItem:setPosition(cc.p(size.width / 2 + 40, size.height / 2 - 100))
	local function aboutItemCallback()
		print("aboutItemCallback")
		local GameAboutScene = require "GameAboutScene"
		local aboutScene = GameAboutScene:create()
		local tranScene  = cc.TransitionPageTurn:create(1, aboutScene, false)
		director:pushScene(tranScene)
	end
	aboutItem:registerScriptTapHandler(aboutItemCallback)
	mn:addChild(aboutItem)

		-- Sound Item
	local soundItem = cc.MenuItemImage:create("sound-on-A.png", "sound-on-B.png")
	soundItem:setPosition(cc.p(80, 60))
	local function soundItemCallback()
		print("soundItemCallback")
		if not issound then
			soundItem:setNormalImage(cc.Sprite:create("sound-on-A.png"))
			soundItem:setDisabledImage(cc.Sprite:create("sound-on-B.png"))
			if isfirst then 
				AudioEngine.playMusic(MUSIC_FILE1, true)
				isfirst = false
			else
				AudioEngine.playMusic(MUSIC_FILE, true)
				isfirst = true
			end
			issound = true
		else
			soundItem:setNormalImage(cc.Sprite:create("sound-off-A.png"))
			soundItem:setDisabledImage(cc.Sprite:create("sound-off-B.png"))  -- ?? no effect
			AudioEngine.stopMusic()
			issound = false
		end
	end
	soundItem:registerScriptTapHandler(soundItemCallback)
	local mn_sound = cc.Menu:create()
	mn_sound:setPosition(cc.p(0, 0))
	mn_sound:addChild(soundItem)

	layer:addChild(mn, 1, 3)
	layer:addChild(mn_sound, 1)

	return layer
end

function GameMenuScene:create()
	local scene = cc.Scene:create()
	local layer = GameMenuScene:createLayer()
	scene:addChild(layer)

	local mn = layer:getChildByTag(3)
	local function onEnter()
		print "onEnter()"
		mn:setScale(0.5)
		local act1 = cc.ScaleTo:create(0.5, 1.1)
		local act2 = cc.ScaleTo:create(0.2, 1)
		local seq  = cc.Sequence:create(act1, act2)
		mn:runAction(seq)
	end

	local function onExit()
		-- body
	end

	local function onNodeEvent(event)
		if event == "enter" then
			onEnter()
		elseif event == "exit" then
			onExit()
		end
	end

	scene:registerScriptHandler(onNodeEvent)

	-- inti Sound
	issound = true
	isfirst = true
	AudioEngine.preloadMusic(MUSIC_FILE)
	AudioEngine.setMusicVolume(0.5)
	AudioEngine.playMusic(MUSIC_FILE, true)

	return scene
end

return GameMenuScene