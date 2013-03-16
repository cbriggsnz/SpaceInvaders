
-- bullet.lua

local bullet = {}
local bullet_mt = { __index = bullet}
local scene = scene


function bullet:new() -- constructor
	local group = {}
   return setmetatable( group, bullet_mt )
end

function bullet:enterFrame()
	self.bullet.y = self.bullet.y - 10
end

function bullet:init(xloc) --initializer
	-- Create attributes
	self.bullet = display.newRect(xloc,890,4,15)
	self.bullet:setReferencePoint( CenterReferencePoint )
	self.bullet:setFillColor ( 0, 255, 0  )
	self.bullet.name = "bullet"
	
	local borderCollisionFilter = { categoryBits = 1, maskBits = 25} 
	physics.addBody( self.bullet,  "dynamic", {filter = borderCollisionFilter})
	
	return true
end
 
function bullet.collision(self, event)
	Runtime:removeEventListener( "enterFrame", self )
	self.bullet:removeSelf()
	self = nil
end

function bullet:start()
	---  Create Listeneres
	Runtime:addEventListener( "enterFrame", self )
	self.bullet:addEventListener( "collision", self )
end

return bullet