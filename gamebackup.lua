local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- local forward references should go here --

local whiteSqrs = {}
local blackSqrs = {}
local sqrLocations = {}
local whiteSqr
local blackSqr
local sqrLocation
local goalText
local timeLeft
local bg

--local x = 0
--local y = 0

local idx = 0
local x = 0
local y = 0
local tableIndexNum
local tableIdx
local sum = 0
local score = math.random(30, 80)
local randomNum
local time = 5
local youWin = false
local transitionEnd = false

local bgGroup
local whiteGroup
local blackGroup
local uiGroup

local function goalReached ()
    youWin = true
    display.remove(timeLeft)
    local winText = display.newText(uiGroup, "YOU WIN!", 0, 0, native.systemFont, 30)
    winText.x = centerX
    winText.y = centerY + 200
end

local function goalNotReached ()
    youWin = true
    display.remove(timeLeft)
    local loseText = display.newText(uiGroup, "YOU LOSE!", 0, 0, native.systemFont, 30)
    loseText.x = centerX
    loseText.y = centerY + 200
    
    local function loadDelay ()
        storyboard.gotoScene ( "menu", { effect = "crossFade" } )
    end

    timer.performWithDelay(500, loadDelay)
end

local function theTableIdx (sum)
    display.remove(tableIndexNum)
    tableIndexNum = display.newText(uiGroup, tostring(sum), 0, 0, native.systemFont, 30)
    tableIndexNum.x = centerX + 130
    tableIndexNum.y = centerY - 58
    
    if (sum == score) then
        goalReached()
    elseif (sum > score or #whiteSqrs == 0) then
        display.remove(timeLeft)
        goalNotReached()
    end
end

local function sqrTouched (event)
    local obj = event.target
    local tableLength = #whiteSqrs
   
    tableIdx = table.indexOf(whiteSqrs, obj)
    table.remove(whiteSqrs, tableIdx)
    obj:removeSelf()
    transition.to(sqrLocations[tableIdx], {time=300, alpha=0, width=1, height=1})
    table.remove(sqrLocations, tableIdx)

    sum = sum + tableIdx
    theTableIdx(sum)
    randomNum = math.random(1, tableLength)
    
    --Removes a random square if randonNum and the obj.idx aren't the same
    if (randomNum ~= tableIdx) then
        display.remove(whiteSqrs[randomNum])
        table.remove(whiteSqrs, randomNum)
        transition.to(sqrLocations[randomNum], {time=300, alpha=0, width=1, height=1})
        table.remove(sqrLocations, randomNum)
    end
    
    --Resets the time
    time = 5
end

local function startLoop() 
            if (x < 4) then
                if (y < 5) then
                    y = y + 1
                    idx = idx + 1
                    
                    sqrLocation = display.newRect(whiteGroup, 0, 0, 40, 40)
                    sqrLocation.x = (x * 50) + 85
                    sqrLocation.y = (y * 50) + 30
                    sqrLocation.alpha = 0
                    
                    whiteSqr = display.newRect(whiteGroup, 0, 0, 40, 40)
                    whiteSqr.x = (x * 50) + 85 --((x - 5) * 60) + 10 
                    whiteSqr.y = (y * 500) + 10 --(y * 60) + 10
                    
                    blackSqr = display.newRect(blackGroup, 0, 0, 40, 40)
                    blackSqr.x = whiteSqr.x + 3
                    blackSqr.y = whiteSqr.y + 3 
                    blackSqr.alpha = 0.2
                    blackSqr:setFillColor(black)
                    
                    table.insert(whiteSqrs, whiteSqr)
                    table.insert(blackSqrs, blackSqr)
                    table.insert(sqrLocations, sqrLocation)
                    --print(#whiteSqrs)
                    
                    if (y == 5) then
                        y = 0
                        x = x + 1
                    end
                    
                    local function showGoalText ()
                        if (idx == 20) then
                            local function timerText ()
                                goalText = display.newText(uiGroup, tostring(score), 0, 0, native.systemFont, 70)
                                goalText.x = centerX 
                                goalText.y = centerY + 130
                                goalText.alpha = 0
                                transition.to(goalText, {time=500, alpha=1})
                                for idx = 1, #sqrLocations do
                                    sqrLocations[idx].alpha = 1
                                end
                            end
                            timer.performWithDelay(1000, timerText)
                        end
                    end
          
                    transition.to(whiteSqr, {time=1000, x=sqrLocation.x, y=sqrLocation.y, transition=easing.inOutQuad, onComplete=showGoalText})
                    transition.to(blackSqr, {time=1000, x=sqrLocation.x + 7, y=sqrLocation.y + 7, transition=easing.inOutQuad})
                    whiteSqr:addEventListener("tap", sqrTouched)
                    --timer.performWithDelay(100, startLoop)
                end
            end
        end

-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view
        
        bgGroup = display.newGroup()
        group:insert(bgGroup)
        
        blackGroup = display.newGroup()
        group:insert(blackGroup)
        
        whiteGroup = display.newGroup()
        group:insert(whiteGroup)
        
        uiGroup = display.newGroup()
        group:insert(uiGroup)
        
        bg = display.newRect(bgGroup, 0, 0, 320, 480)
        bg.x = centerX
        bg.y = centerY
        bg:setFillColor(.5)
        
        timer.performWithDelay(100, startLoop, 20)
  
        timer.performWithDelay(4000, countDownTimer)
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local group = self.view

        storyboard.removeScene("menu")

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view

        

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