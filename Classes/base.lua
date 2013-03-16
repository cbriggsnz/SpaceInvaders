

-- base.lua

local base = {}
local base_mt = { __index = base}
local scene = scene

local block = require("Classes.block")

function base:new() -- constructor
	local group = {}
   return setmetatable( group, base_mt )
end

function base:init(xloc, yloc) --initializer
	-- Create attributes
	local base
	for j = 1, 2 do
		for i = 1, 4 do
			base = block:new()
			base:init(xloc+i * 33,yloc+j * 33)
			base:start()
		end
	end

		    
	    
end

return base