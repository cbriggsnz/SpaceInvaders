local scene = scene

local hud = {}
local score
function hud:new()
	local title = display.newText("Level 1", 0, 0, native.systemFont, 56)
	title:setTextColor(255)
	title:setReferencePoint(display.CenterReferencePoint)
	title.x = display.contentWidth / 2
	score = display.newText("0", 0, 0, native.systemFont, 48)
	score:setTextColor(255)
	score:setReferencePoint(display.CenterReferencePoint)
	score.x = display.contentWidth / 2
	score.y = display.contentHeight - 35
end

function hud:enemyDead()
	print ("Points go up")
	score.text = score.text + 10
end

function hud:start()
	scene:addEventListener("enemyDead",self)

end
return hud