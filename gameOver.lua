-------------
-- File: gameOver.lua
-- Authors: Mordecai Ebhohon and Gordon Wu
-- Description: Shows a menu screen once the game is over and the 
--              user has been hit.
-------------

local composer = require("composer")

math.randomseed(os.time())

local scene = composer.newScene()

local function gotoGame()
	composer.gotoScene("game")
end
	
local function gotoHighScores()
	composer.gotoScene("highscores")
end
	
-- TODO: show this menu once the game has ended
-- Function that creates the gameover menu
-- Right now it doesn't show at all once the game had ended
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
	
-- Function to show the gameover event 
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
	