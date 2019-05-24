-------------
-- File: menu.lua
-- Authors: Mordecai Ebhohon and Gordon Wu
-- Description: Shows a menu screen when the game is loaded up.
-------------

local composer = require("composer")

local scene = composer.newScene()

-- Function that moves the user to the game and out of the menu
local function gotoGame()
	composer.removeScene("game")
	composer.gotoScene("game")
end

-- TODO: make a highscores menu
local function gotoHighScores()
	composer.removeScene("highscores")
	composer.gotoScene("highscores")
end

-- Function that creates the menu and allows the user to start the game
-- once the play button is tappped
function scene:create(event)
	local sceneGroup = self.view
	
	local background = display.newImageRect(sceneGroup,"Images/Menu.jpg",600,400)
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	
	local gameText = display.newImageRect(sceneGroup, "Images/Play.png",80,60)
	gameText.x = 320
	gameText.y = 120
	local highScoreText = display.newImageRect(sceneGroup, "Images/Menu.png",80,60)
	highScoreText.x = 320
	highScoreText.y = 180
	
	gameText:addEventListener("tap", gotoGame)
	highScoreText:addEventListener("tap", gotoHighScores)
end
	
-- Function to show the menu event 
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
	end
end

-- Function to hide the scene 
function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
	end
end

-- Function to destroy the scene once done
function scene:destroy( event )
	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
	