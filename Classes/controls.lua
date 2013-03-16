

-- enemy.lua

local controls = {}
local controls_mt = { __index = controls }

local scene = scene


function controls:new() -- constructor
	local group = {}
   return setmetatable( group, enemys_mt )
end

function controls:init() --initializer
	-- Create attributes
	self.rightArrow = display.newImage("Assets/rightArrow.png")
	self.rightArrow:setReferencePoint( CenterReferencePoint )
	self.rightArrow.x = display.contentWidth - 50
	self.rightArrow.y = display.contentHeight - 40
	
	self.leftArrow = display.newImage("Assets/rightArrow.png")
	self.leftArrow:setReferencePoint( CenterReferencePoint )
	self.leftArrow:rotate(180)
	self.leftArrow.x = display.contentWidth - 130
	self.leftArrow.y = display.contentHeight - 40

	self.myCircle = display.newCircle( 50, display.contentHeight - 40, 30 )
	self.myCircle:setFillColor(253, 0, 8)
	self.myCircle.strokeWidth = 5
	self.myCircle:setStrokeColor(255, 255, 255)


end

local function leftTouch( event )
    if event.phase == "began" then
    	local touchEvent = {
    		name = "buttonTouched",
    		id = "LeftButtonTouched"
    		}
    scene:dispatchEvent(touchEvent)
    elseif event.phase == "ended" or event.phase == "cancelled" then 
    	 local touchEvent = {
    		name = "buttonTouched",
    		id = "LeftButtonReleased"
    		}
    scene:dispatchEvent(touchEvent)
    end
    return true
end

local function rightTouch( event )
    if event.phase == "began" then
    	local touchEvent = {
    		name = "buttonTouched",
    		id = "RightButtonTouched"
    		}
    scene:dispatchEvent(touchEvent)
    elseif event.phase == "ended" or event.phase == "cancelled" then 
    	 local touchEvent = {
    		name = "buttonTouched",
    		id = "RightButtonReleased"
    		}
    scene:dispatchEvent(touchEvent)
    end
    return true
end

local function fireTouch( event )
    if event.phase == "began" then
    	local touchEvent = {
    		name = "buttonTouched",
    		id = "FireButtonTouched"
    		}
    scene:dispatchEvent(touchEvent)
    end
    return true
end

function controls:start()
	---  Create Listeneres
	self.leftArrow:addEventListener("touch", leftTouch)
	self.rightArrow:addEventListener("touch",rightTouch)
	self.myCircle:addEventListener("touch",fireTouch)
end



return controls