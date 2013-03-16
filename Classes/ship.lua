
-- enemy.lua
local storyboard = require("storyboard")
bullets = require("Classes.bullet")
local ship = {}
local ship_mt = { __index = ship }

local scene = scene


function ship:new() -- constructor
	local group = {}
   return setmetatable( group, enemys_mt )
end

function ship:init(xloc, yloc) --initializer
	-- Create attributes
	self.spaceship = display.newGroup()  -- new group for spaceship
	self.spaceship.name = "ship"
	self.turret = display.newRect(self.spaceship,30,0,4,15)
	self.turret:setFillColor ( 0, 255, 0  )
	self.turret:setReferencePoint(display.CenterReferencePoint)
	self.image = display.newRect(self.spaceship,0,10,60,20)
	self.image:setFillColor ( 0, 255, 0  )
	self.image:setReferencePoint(display.CenterReferencePoint)
	self.spaceship.x = display.contentWidth / 2
	self.spaceship.y = display.contentHeight - 120
	self.bullet = require("Classes.bullet")
	self.direction = -4
	self.bulletFired = {}
	
	local borderCollisionFilter = { categoryBits = 4, maskBits = 6} 
	physics.addBody( self.spaceship,  "dynamic", {filter = borderCollisionFilter})
	

end

function ship:enterFrame()
	self.spaceship.x = self.spaceship.x + self.direction
end

function ship:buttonTouched(event)
	if (event.id == "LeftButtonTouched") then
		self.direction = -4
		Runtime:addEventListener( "enterFrame", self )
	elseif (event.id == "LeftButtonReleased") then
		Runtime:removeEventListener( "enterFrame", self )
	elseif (event.id == "RightButtonTouched") then
		self.direction = 4
		Runtime:addEventListener( "enterFrame", self )
	elseif (event.id == "RightButtonReleased") then
		Runtime:removeEventListener( "enterFrame", self )
	elseif (event.id == "FireButtonTouched") then
		local bullet = bullets:new()
		bullet:init(self.spaceship.x +30)
		bullet:start()
		print("FIRE!!!")
		--Runtime:removeEventListener( "enterFrame", self )
	end
	
end

function ship.collision(self, event) -- collision listener
	if event.other.name == "bomb" then
		print("Collision")
		Runtime:removeEventListener( "enterFrame", self )
		self.spaceship:removeEventListener( "collision", self ) -- collided with another physics body
		self.spaceship:removeSelf()
		self = nil
		message = {
			name = "gameOver"
			}
		scene:dispatchEvent(message)
	end
end

function ship:start()
	---  Create Listeneres
	scene:addEventListener("buttonTouched", self)
	self.spaceship:addEventListener( "collision", self ) -- collided with another physics body

end

return ship