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

bgColor = .75

topWin = false
rightWin = false
botWin = false
leftWin = false

lvlsCompleted = 0

function completed (num)
	lvlsCompleted = lvlsCompleted + num
	print(lvlsCompleted)
end


composer.gotoScene ( "menu", { effect = "crossFade" } )







