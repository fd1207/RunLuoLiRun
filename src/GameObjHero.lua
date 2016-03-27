
GameObjHero = class("GameObjHero", function () 
	return cc.Sprite:create() 
end)

local hero
local runningActionTag = 1
local jumpingActionTag = 2
local hurtingActionTag = 3

local runningState  = 4
local jumpingState  = 5
local hurtingState  = 6
local droppingState = 7

GameObjHero.hurtable = true

function GameObjHero:onEnter()
	local obj = cc.Sprite:create("s_hurt.png")
	self.hurtTexture = obj:getTexture()
	local obj = cc.Sprite:create("s_jump.png")
	self.jumpTexture = obj:getTexture()
	self:setTexture("s_1.png")

	-- Animation
	local animation = cc.Animation:create()
	for i = 1, 8 do
		local name = string.format("s_%d.png", i)
		animation:addSpriteFrameWithFile(name)
	end
	animation:setDelayPerUnit(0.08)
	animation:setRestoreOriginalFrame(true)
	local runningAction = cc.Animate:create(animation)
	local repeatedRunningAction = cc.RepeatForever:create(runningAction)
	repeatedRunningAction:setTag(runningActionTag)
	self:runAction(repeatedRunningAction)
	self.state = 0
end

function GameObjHero:setState(states)
	local var = states[1]
	if self.state == var then
		return
	end
	self.state = var
	if self.state == runningState then  -- Running
		self:stopActionByTag(jumpingActionTag)
		self:stopActionByTag(hurtingActionTag)
		local animation = cc.Animation:create()
		for i = 1, 8 do
			local name = string.format("s_%d.png", i)
			animation:addSpriteFrameWithFile(name)
		end
		animation:setDelayPerUnit(0.12)
		animation:setRestoreOriginalFrame(true)
		local action = cc.Animate:create(animation)
		local runningAction = cc.RepeatForever:create(action)
		runningAction:setTag(runningActionTag)
		self:runAction(runningAction)
	elseif self.state == jumpingState then -- Jump
		local sp = cc.Sprite:create()
		self:stopActionByTag(runningActionTag)
		self:stopActionByTag(hurtingActionTag)
		self:setTexture(self.jumpTexture)
		local jumpingAction = cc.JumpBy:create(2, cc.p(0, 0), 200, 1)
		jumpingAction:setTag(jumpingActionTag)
		local seq = cc.Sequence:create(jumpingAction, cc.CallFunc:create(GameObjHero.setState, {runningState}))
		-- CallFunc中注册的setState传入的self是指hero
		self:runAction(seq)
	elseif hero.state == hurtingState then -- Hurt
		-- self:stopActionByTag(runningActionTag)
		-- self:stopActionByTag(jumpingActionTag)
		self:stopAllActions()
		self:setTexture(self.hurtTexture)
		self.hurtable = false
		local hurtingAction = cc.Blink:create(1.5, 3)
		hurtingAction:setTag(hurtingActionTag)
		local seq = cc.Sequence:create(hurtingAction, cc.CallFunc:create(GameObjHero.hurtRecover))
		self:runAction(seq)
	elseif hero.state == droppingState then
		self:stopAllActions()
		local dropAction = cc.MoveBy:create(2, cc.p(0, -400))
		local seq = cc.Sequence:create(dropAction, cc.CallFunc:create(GameObjHero.gameOver))
		self:runAction(seq)
	end
end

function GameObjHero:drop()
	--print("drop()")
	bg1:stopAllActions()
	bg2:stopAllActions()
	self:setState({droppingState})
end

function GameObjHero:hurted()
	bg1:stopAllActions()
	bg2:stopAllActions()
	self:setState({hurtingState})
end

function GameObjHero:hurtRecover()
	-- self.hurtable = true
	self:gameOver()
	-- self:setState({runningState})
end

function GameObjHero:gameOver()
	local gameOverScene = GameOverScene:create()
	director:replaceScene(gameOverScene)
end

function GameObjHero:touchListener(layer)
	local function touchCallback()
		if hero.hurtable then
			hero:setState({jumpingState})
		end
	end
	local listener = cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(touchCallback, cc.Handler.EVENT_TOUCH_BEGAN )
	local eventDispatcher = director:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
end

function GameObjHero:create()
	hero = GameObjHero.new()
	hero:onEnter()

	return hero
end