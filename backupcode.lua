local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- local forward references should go here --
--[[
local function sqrTouched (event)
    local phase = event.phase
    local obj = event.target
    local length = #whiteSqrs
    if (phase == "began") then
        display.getCurrentStage():setFocus(obj)
        time = 5
        tableIdx = table.indexOf(whiteSqrs, obj)
        if (tableIdx == nil) then
            randomNum = math.random(1, length - 1)
            tableIdxSum = tableIdxSum + length
            display.remove(whiteSqrs[randomNum])
            display.remove(obj)
            display.remove(tableIndexNum)
            table.remove(whiteSqrs, randomNum)
            table.remove(whiteSqrs, tableIdx)
            theTableIdx()
        end
    elseif (phase == "moved") then
        display.getCurrentStage():setFocus(obj)
    elseif (phase == "ended" or phase == "cancelled") then
        display.getCurrentStage():setFocus(nil)
        
        if (tableIdx == nil) then
            if(obj == nil) then
                display.remove(obj)
            else
                obj:removeSelf()
            end
        elseif (tableIdx == length) then
            randomNum = math.random(1, length - 1)
        elseif (tableIdx + 1 < length) then
            randomNum = math.random(tableIdx + 1, length)
        elseif (tableIdx < length) then    
            randomNum = math.random(1, length)
        end
        
        if (tableIdx == nil) then
            if(obj == nil) then
                display.remove(obj)
            else
                obj:removeSelf()
            end
        else
            display.remove(whiteSqrs[randomNum])
            display.remove(obj)
            display.remove(tableIndexNum)
            table.remove(whiteSqrs, randomNum)
            table.remove(whiteSqrs, tableIdx)
            tableIdxSum = tableIdxSum + tableIdx
            theTableIdx()
            if (#whiteSqrs <= 1) then
                whiteGroup:removeSelf(whiteSqr)
                goalNotReached()
            end 
        end
    end
end


local function sqrTouched (event)
    local phase = event.phase
    local obj = event.target
    local tableLength = #whiteSqrs
    tableIdx = table.indexOf(whiteSqrs, obj)
    if event.phase == "began" then
        
        display.getCurrentStage():setFocus( obj )
        obj.isFocus = true
        
        
        
        
        --print(tableLength .. "before")
    elseif obj.isFocus then
        
        if event.phase == "moved" then
           
            obj.isFocus = false
           
        elseif event.phase == "ended" then
            table.remove(whiteSqrs, tableIdx)
            obj:removeSelf()
            sum = sum + tableIdx
            theTableIdx(sum)
            
            randomNum = math.random(1, tableLength)
            
            if (randomNum ~= tableIdx) then
                display.remove(whiteSqrs[randomNum])
                table.remove(whiteSqrs, randomNum)
            end
            
            --Resets the time
            time = 5
            display.getCurrentStage():setFocus( nil )
            obj.isFocus = false
        end
    end
end

 local function countDownTimer ()
    if (time > 0 and youWin == false) then
        display.remove(timeLeft)
        
        time = time - 1
        
        timeLeft = display.newText(uiGroup, tostring(time), 0, 0, native.systemFont, 100)
        timeLeft.x = centerX
        timeLeft.y = centerY + 130
    
        timer.performWithDelay(1000, countDownTimer)
    elseif (time == 0) then
        display.remove(timeLeft)
        goalNotReached()
    end
end
--]]
-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view

        --      CREATE display objects and add them to 'group' here.
        --      Example use-case: Restore 'group' from previously saved state.

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local group = self.view

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view

        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

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