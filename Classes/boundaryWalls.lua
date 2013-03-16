local scene = scene
local walls = {}

function walls:new()
	local leftWall = display.newRect (0, 0, 1, display.contentHeight);
	leftWall.name = "leftWall"
	local rightWall = display.newRect (display.contentWidth, 0, 1, display.contentHeight);
	rightWall.name = "rightWall"
	local ceiling = display.newRect (0, 0, display.contentWidth, 1);
	local floorWall = display.newRect (0, display.contentHeight, display.contentWidth, 1);
	
	-- Add physics to the walls. They will not move so they will be "static"
	physics.addBody (leftWall, "static",  { bounce = 0.1 } );
	physics.addBody (rightWall, "static", { bounce = 0.1 } );
	physics.addBody (ceiling, "static",   { bounce = 0.1 } );
	physics.addBody (floorWall, "static",   { bounce = 0.1 } );
end
return walls


