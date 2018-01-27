-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require("composer")

display.setStatusBar(display.HiddenStatusBar)

math.randomseed( os.time() )

centerX = display.contentWidth * .5
centerY = display.contentHeight * .5

topWin = false
rightWin = false
botWin = false
leftWin = false




composer.gotoScene ( "menu", { effect = "crossFade" } )







