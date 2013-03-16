-- enemy.lua

local enemys = {}
local enemys_mt = { __index = enemys }

local scene = scene

local bomb = require("Classes.bomb")

function enemys:new() -- constructor
	local group = {}
   return setmetatable( group, enemys_mt )
end

function enemys:init(xloc, yloc) --initializer
	-- Create attributes
	
	self.image = display.newImage("Assets/Enemy.png")
	self.image:setReferencePoint( CenterReferencePoint )
	self.image.x = xloc 
	self.image.y = yloc 
	self.image.name = "enemy"
	self.movement = 2
	self.leftHit = 0
	self.rightHit = 0
	self.numberOfWallHits = 0
	
	local borderCollisionFilter = { categoryBits = 8, maskBits = 9} 
	physics.addBody( self.image,  "dynamic", {filter = borderCollisionFilter})
	

end

local function dropBomb (event,self)
	timer.cancel(self.clock)
	
	local newBomb = bomb:new()
	newBomb:init(self.image.x - 10, self.image.y + 5)
	newBomb:start()
	local delay = math.random(1000,10000)
	self.clock = timer.performWithDelay( delay, function (event) dropBomb(event,self) end, 1)
end


function enemys:start()
	---  Create Listeneres
	Runtime:addEventListener( "enterFrame", self ) -- runtime listener to move the enemy
	self.image:addEventListener( "collision", self ) -- collided with another physics body
	scene:addEventListener('hit_rightWall_event', self)
	scene:addEventListener('hit_leftWall_event', self)
	local delay = math.random(1000,10000)
	self.clock = timer.performWithDelay( delay, function (event) dropBomb(event,self) end, 1)
end

function enemys.enterFrame(self, event) -- runtime listener, moves the Enemy -- notice the '.' instead of ":"
	self.image.x = self.image.x + self.movement
end

local function checkNumHits(self)
	if self.numberOfWallHits == 4 then
		self.numberOfWallHits = 0
		self.movement = self.movement + 1
		 timer.performWithDelay( 1, -- 1 millisecond delay
                    function() -- anonymous function to perform the update
                       self.image.y =self.image.y + 30
                    end
                , 1) 
		
	end
end

function enemys.hit_rightWall_event(self, event)  -- should be called when 'Enemy' hits the right wall 
	self.rightHit = self.rightHit + 1
	if ( self.rightHit == 1 ) then
		self.movement = self.movement * (-1)
		self.leftHit = 0
		self.numberOfWallHits = self.numberOfWallHits + 1
	end
	checkNumHits(self)
end

function enemys.hit_leftWall_event(self, event)  -- should be called when 'Enemy' hits the left wall 
	self.leftHit = self.leftHit + 1
	if ( self.leftHit == 1 ) then
		self.movement = self.movement * (-1)
		self.rightHit = 0
		self.numberOfWallHits = self.numberOfWallHits + 1
	end
	checkNumHits(self)
end


function enemys.collision(self, event) -- collision listener
	if event.other.name == "leftWall" then
		local message = {
                        name="hit_leftWall_event"
                }
		scene:dispatchEvent(message)
	elseif event.other.name == "rightWall" then
		local message = {
                        name="hit_rightWall_event"
                }
		scene:dispatchEvent(message)
	elseif event.other.name == "bullet" then
		message = {
			name = "enemyDead"
			}
		scene:dispatchEvent(message)
		Runtime:removeEventListener( "enterFrame", self )
		self.image:removeEventListener( "collision", self ) -- collided with another physics body
		scene:removeEventListener('hit_rightWall_event', self)
		scene:removeEventListener('hit_leftWall_event', self)
		self.image:removeSelf()
		timer.cancel(self.clock)
		--display.remove(event.other)
	--self:removeSelf()
	end
end

return enemys