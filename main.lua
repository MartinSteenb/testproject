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

local tableSetup = [[CREATE TABLE IF NOT EXISTS GameData (UserID INTEGER PRIMARY KEY autoincrement, FirstName, Score);]]
db:exec(tableSetup)

local dbButton = widget.new

local insert = [[INSERT INTO GameData VALUES (NULL, "Martin", 100);]]
db:exec(insert)


if GameData == nil then
	print("Empty db")
else
	print(GameData)
end

for row in db:nrows("SELECT * FROM GameData") do
	print("row: ", row.UserID, "FirstName", row.FirstName, "Score", row.Score )

end


print(GameData)

centerX = display.contentWidth * .5
centerY = display.contentHeight * .5

bgColor = .75

topWin = false
rightWin = false
botWin = false
leftWin = false




composer.gotoScene ( "menu", { effect = "crossFade" } )







