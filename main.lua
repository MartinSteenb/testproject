-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local storyboard = require( "storyboard" )

display.setStatusBar(display.HiddenStatusBar)

math.randomseed( os.time() )

centerX = display.contentWidth * .5
centerY = display.contentHeight * .5

topWin = false
rightWin = false
botWin = false
leftWin = false




storyboard.gotoScene ( "menu", { effect = "crossFade" } )







