-------------
-- File: HighScores.lua
-- Authors: Mordecai Ebhohon and Gordon Wu
-- Description: Shows the highscores screen when the 'menu' button
-- 				is clicked in the menu. Right now it just shows the 
--     			'play' button and removes the 'menu' button.
-------------

local composer = require("composer")

local scene = composer.newScene()

local function gotoGame()
	composer.gotoScene("game")
end

-- TODO: make the Highscores menu
-- Function that creates the highscores menu
-- Right now it only shows the Play button
function scene:create(event)
	local sceneGroup = self.view
	local background = display.newImageRect(sceneGroup,"Images/Menu.jpg",600,400)
	background.x = display.contentCenterX
	background.y = display.contentCenterY


	local gameText = display.newImageRect(sceneGroup, "Images/Play.png",80,60)
	gameText.x = 320
	gameText.y = 120
	gameText:addEventListener("tap", gotoGame)
end
	
-- Function to show the highscores event 
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
	