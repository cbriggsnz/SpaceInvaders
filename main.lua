-- Project: Inspection App
-- Description:
--
-- Version: 1.0
-- Managed with http://OutlawGameTools.com
--
-- Copyright 2013 . All Rights Reserved.
---- cpmgen main.lua

display.setStatusBar(display.HiddenStatusBar)
local widget = require("widget");
local storyboard = require("storyboard");--Include the storyboard library

local physics = require('physics')  
physics.start()
physics.setGravity(0, 0)
-- load first scene
--storyboard.gotoScene("Storyboard-gameOver");
storyboard.gotoScene("Storyboard-level1");
--The argument is the lua file to load (it has to be a properly prepared file, though)