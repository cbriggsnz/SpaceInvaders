-- bomb.lua

local bomb = {}
local bomb_mt = { __index = bomb}
local scene = scene


function bomb:new() -- constructor
	local group = {}
   return setmetatable( group, bomb_mt )
end

function bomb:init(xloc, yloc) --initializer
	-- Create attributes
	self.bomb =display.newGroup ( )
	local bomb1 = display.newRect( self.bomb,5,5,5,15)
	bomb1:setFillColor ( 247, 255, 94  )
	local bomb1 = display.newRect( self.bomb,0,0,15,5)
	bomb1:setFillColor ( 252, 0, 20  )
	self.bomb.x = xloc
	self.bomb.y = yloc
	self.bomb.name = "bomb"
	local borderCollisionFilter = { categoryBits = 2, maskBits = 22}  
	physics.addBody( self.bomb,  "dynamic", {filter = borderCollisionFilter})
	
end
 
function bomb.collision(self, event)
		print("bomb Kaboom")
		Runtime:removeEventListener( "enterFrame", self )
		self.bomb:removeEventListener( "collision", self )
		self.bomb:removeSelf()
		self = nil
end

function bomb:enterFrame()
	self.bomb.y = self.bomb.y + 10
end

function bomb:start()
	---  Create Listeneres
	Runtime:addEventListener( "enterFrame", self )
	self.bomb:addEventListener( "collision", self )
end

return bomb