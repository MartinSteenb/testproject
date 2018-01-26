local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- local forward references should go here --

local objects

local bg
local top
local right
local bot
local left

local delayTimer
local xVal
local yVal
local levIdx

local objects
local blackSqrs
local background

local function buttonEffect (obj)
    local function loadDelay ()
      if levIdx == 1 then
          storyboard.gotoScene ( "topLevel", { effect = "crossFade" } )
      elseif levIdx == 2 then
          storyboard.gotoScene ( "rightLevel", { effect = "crossFade" } )
      elseif levIdx == 3 then
          storyboard.gotoScene ( "botLevel", { effect = "crossFade" } )
      elseif levIdx  == 4 then
          storyboard.gotoScene ( "leftLevel", { effect = "crossFade" } )
      end
    end
    
    if obj.name == "top" then
        xVal = 0
        yVal = -50
        levIdx = 1
    elseif obj.name == "right" then
        xVal = 50
        yVal = 0
        levIdx = 2
    elseif obj.name == "bot" then
        xVal = 0
        yVal = 50
        levIdx = 3
    elseif obj.name == "left" then
        xVal = -50
        yVal = 0
        levIdx = 4
    end
    
    transition.to(
        obj,
        {
          time=750,
          x=obj.x + xVal,
          y=obj.y + yVal,
          alpha=0
        }
    )
    
    
    delayTimer = timer.performWithDelay(750, loadDelay)
end

local function loadLevel (event)
    local obj = event.target
    
    if event.phase == "began" then
        display.getCurrentStage():setFocus( obj )
        obj.isFocus = true
        buttonEffect(obj)
    elseif obj.isFocus then
        if event.phase == "moved" then
            obj.isFocus = false
        elseif event.phase == "ended" or event.phase == "cancelled" then
            display.getCurrentStage():setFocus( nil )
            obj.isFocus = false
        end
    end
end



-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view
        
        background = display.newGroup()
        group:insert(background)
        
        blackSqrs = display.newGroup()
        group:insert(blackSqrs)
        
        objects = display.newGroup()
        group:insert(objects)
        
        bg = display.newRect( 0, 0, 320, 480)
        bg.x = centerX
        bg.y = centerY
        bg:setFillColor(.5)
        background:insert(bg)
        
        if topWin == false then
            top = display.newRect(0, 0, 40, 40)
            top.x = centerX 
            top.y = centerY - 40
            top.rotation = 45
            top.name = "top"
            objects:insert(top)
            top:addEventListener("touch", loadLevel)
        else
            top = display.newRect(0, 0, 40, 40)
            top.x = centerX 
            top.y = centerY - 40
            top.rotation = 45
            objects:insert(top)
            top:setFillColor(black)
            top.alpha = .2
        end
        
        if rightWin == false then
            right = display.newRect(0, 0, 40, 40)
            right.x = centerX + 30
            right.y = centerY - 10
            right.rotation = 45
            right.name = "right"
            objects:insert(right)
            right:addEventListener("touch", loadLevel)
        else
            right = display.newRect(0, 0, 40, 40)
            right.x = centerX + 30
            right.y = centerY - 10
            right.rotation = 45
            objects:insert(right)
            right:setFillColor(black)
            right.alpha = .2
        end
        
        if botWin == false then
            bot = display.newRect(0, 0, 40, 40)
            bot.x = centerX 
            bot.y = centerY + 20
            bot.rotation = 45
            bot.name = "bot"
            objects:insert(bot)
            bot:addEventListener("touch", loadLevel)
        else
            bot = display.newRect(0, 0, 40, 40)
            bot.x = centerX 
            bot.y = centerY + 20
            bot.rotation = 45
            objects:insert(bot)
            bot:setFillColor(black)
            bot.alpha = .2
        end
        
        if leftWin == false then
            left = display.newRect( 0, 0, 40, 40)
            left.x = centerX - 30 
            left.y = centerY - 10
            left.rotation = 45
            left.name = "left"
            objects:insert(left)
            left:addEventListener("touch", loadLevel)
        else
            left = display.newRect( 0, 0, 40, 40)
            left.x = centerX - 30 
            left.y = centerY - 10
            left.rotation = 45
            objects:insert(left)
            left:setFillColor(black)
            left.alpha = .2
        end
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local group = self.view

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)
    
        storyboard.removeScene("topLevel")
        storyboard.removeScene("rightLevel")
        storyboard.removeScene("botLevel")
        storyboard.removeScene("leftLevel")
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view

        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
        --right:removeEventListener("touch", loadLevel)
        --timer.cancel(delayTimer)
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view

        --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

end



---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )


---------------------------------------------------------------------------------

return scene