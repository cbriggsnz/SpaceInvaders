
-- block.lua

local block = {}
local block_mt = { __index = block}
local scene = scene


function block:new() -- constructor
	local group = {}
   return setmetatable( group, block_mt )
end

function block:init(xloc,yloc) --initializer
	-- Create attributes
	self.block = display.newRect( xloc,yloc,30,30)
	self.block:setFillColor ( 2, 255, 14  )
	local borderCollisionFilter = { categoryBits = 16, maskBits = 19}  
	physics.addBody( self.block,  "dynamic", {filter = borderCollisionFilter})
	self.count = 1
end
 
function block.collision(self, event)
		print("block Kaboom")
		if self.count == 1 then
			self.block:setFillColor ( 0, 189, 27 )
			self.count = self.count + 1
		elseif self.count == 2 then
			self.block:setFillColor (0, 84, 21 )
			self.count = self.count + 1
		elseif self.count == 3 then
			self.block:removeEventListener( "collision", self )
			self.block:removeSelf()
			self = nil
		end
		
end


function block:start()
	---  Create Listeneres
	self.block:addEventListener( "collision", self )
end

return block