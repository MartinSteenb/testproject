-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require("composer")
local sqlite3 = require("sqlite3")
local widget = require("widget")

local path = system.pathForFile("test.db", system.DocumentsDirectory)
local db = sqlite3.open(path)

display.setStatusBar(display.HiddenStatusBar)

math.randomseed( os.time() )

centerX = display.contentWidth * .5
centerY = display.contentHeight * .5

bgColor = .75

topWin = false
rightWin = false
botWin = false
leftWin = false



local function onRowRender (event)
    local row = event.row

    local font = native.systemFont
    local fontSize = 24
    local rowHeight = row.height / 2

    local options_id = {
        parent = row,
        text = row.params.ID,
        x = 50,
        y = rowHeight,
        font = font,
        fontSize = fontSize,
    }

    row.id = display.newText(options_id)
    row.id.anchorX = 0
    row.id:setFillColor(black)

    local options_name = {
        parent = row,
        text = row.params.FirstName,
        x = 50,
        y = rowHeight,
        font = font,
        fontSize = fontSize,
    }

    row.params.FirstName = display.newText(options_name)
    row.params.FirstName:setFillColor(black)
    row.params.FirstName.x = row.id.anchorX+150

    local options_score = {
        parent = row,
        text = row.params.Score,
        x = 50,
        y = rowHeight,
        font = font,
        fontSize = fontSize,
    }

    row.params.Score = display.newText(options_score)
    row.params.Score:setFillColor(black)
    row.params.Score.x = row.params.FirstName.x+100

end

local function printDB ()
    local table_options = {
        top = 75,
        hideBackground = true,
        onRowRender = onRowRender,
    }   
    local tableView = widget.newTableView(table_options)
    --uiGroup:insert(tableView)

    for row in db:nrows("SELECT * FROM GameData WHERE UserID <= 7") do
        print("row: ", row.UserID, "FirstName", row.FirstName, "Score", row.Score )
        
        local rowParams = {
            ID = row.UserID,
            FirstName = row.FirstName,
            Score = row.Score,
        }

        tableView:insertRow(
            {   
                rowHeight = 50,
                params = rowParams,
            }
        )
    end
end

local function submitTapped (userInput, score)
	local score = 101
	
	local insert = [[INSERT INTO GameData VALUES (NULL,"]] .. userInput .. [[", "]] .. score .. [[");]]
	db:exec(insert)
	printDB()
end

local function emptyTapped ()
	dbDeleted = true
	for row in db:nrows("SELECT * FROM GameData") do
		local deleteQuery = [[DELETE FROM GameData WHERE UserID >= 0;]]
		db:exec(deleteQuery)
	end
end	

local function textListener(event)
	local phase = event.phase
	local obj = event.target
	local text = event.target.text
	if ( event.phase == "began" ) then
        -- User begins editing "defaultField"
 
    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        -- Output resulting text from "defaultField"
        --print( text )
 		submitTapped(text)
 		local text = display.newText(text, centerX, centerY+200, native.systemFont, 20) 
 		obj:removeSelf()
    elseif ( event.phase == "editing" ) then

    end
end

local function closeDB ()
	if db and db:isopen() then
		db:close()
	end
end


local tableSetup = [[CREATE TABLE IF NOT EXISTS GameData (UserID INTEGER PRIMARY KEY , FirstName, Score);]]
db:exec(tableSetup)

local userInput = native.newTextField(centerX, centerY-125, 200, 50)
userInput:addEventListener("userInput", textListener)

local submitButton = display.newText("SUBMIT USER", centerX, centerY-175, native.systemFont, 20) 

local emptyButton = display.newText("EMPTY DB", centerX, centerY+100, native.systemFont, 30) 
emptyButton:addEventListener("tap", emptyTapped)

composer.gotoScene ( "menu", { effect = "crossFade" } )







