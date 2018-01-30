-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require("composer")
local sqlite3 = require("sqlite3")
local widget = require("widget")

local path = system.pathForFile("highscores.db", system.DocumentsDirectory)
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

local idx = 0
local dbLength = {}
local dbDeleted = false

local function printDB ()
	for row in db:nrows("SELECT * FROM GameData") do
		print("row: ", row.UserID, "FirstName", row.FirstName, "Score", row.Score )
		
		dbLength[#dbLength+1] = 
		{
			ID = row.UserID,
			FirstName = row.FirstName,
			Score = row.Score
		}

		table.insert(dbLength, #dbLength+1, row.FirstName )
		--print(dbLength[1].ID)
	end
	db:close()
end

local function submitTapped (name)
	local userInput = name
	
	if dbDeleted then
		idx = 0
		dbDeleted = false
	else
		idx = idx + 1
	end
	
	local insert = [[INSERT INTO GameData VALUES (]] .. idx .. [[,"]] .. userInput .. [[", "100");]]
	db:exec(insert)
	printDB()
	print(idx)
end

local function emptyTapped ()
	dbDeleted = true
	for row in db:nrows("SELECT * FROM GameData") do
		local deleteQuery = [[DELETE FROM GameData WHERE UserID >= 0;]]
		db:exec(deleteQuery)
		print("row: ", row.UserID, "FirstName", row.FirstName, "Score", row.Score )	
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


local tableSetup = [[CREATE TABLE IF NOT EXISTS GameData (UserID INTEGER PRIMARY KEY , FirstName, Score);]]
db:exec(tableSetup)

local userInput = native.newTextField(centerX, centerY-125, 200, 50)
userInput:addEventListener("userInput", textListener)

local submitButton = display.newText("SUBMIT USER", centerX, centerY-175, native.systemFont, 20) 
submitButton:addEventListener("tap", submitTapped)

local emptyButton = display.newText("EMPTY DB", centerX, centerY+100, native.systemFont, 30) 
emptyButton:addEventListener("tap", emptyTapped)






composer.gotoScene ( "menu", { effect = "crossFade" } )







