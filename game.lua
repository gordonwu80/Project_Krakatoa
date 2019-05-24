-------------
-- File: game.lua
-- Authors: Mordecai Ebhohon and Gordon Wu
-- Description: The main file of the project, displays the 
-- 				hero, spawns the objects onto the map, and
--				shows their interactions.
-------------

local composer = require("composer")

math.randomseed(os.time())

local scene = composer.newScene()

-- Adds physics to the objects on the screen
local physics = require("physics")
physics.start() 

-- Function to create the scene 
function scene:create(event)
	local sceneGroup = self.view
	physics.pause()

	-- Adds the background to the game
	local background = display.newImage("Images/Background.jpg")
	background.x = 240
	background.y = 150

	-- Hero Initialization
	local hero = display.newImageRect("Images/Character2.png",95,95)
	hero.x = display.contentWidth/2 
	hero.y = display.contentHeight/2
	hero.name = "Mordecai"
	hero.type = "hero"
	hero.level = 1

	hero.x = 250
	hero.y = 274
	physics.addBody(hero, "static", {density=1, friction= .5, radius=25})

	-- Score Initializaton and Display
	scoreTF = display.newText('0', 450, 20, 'Marker Felt', 26)
	scoreTF:setTextColor(255, 255, 255)

	-- Function to show the event once the game is called
	function scene:show( event )
		local sceneGroup = self.view
		local phase = event.phase

		if ( phase == "will" ) then
			-- Code here runs when the scene is still off screen (but is about to come on screen)
		elseif ( phase == "did" ) then
			physics.start()
			-- Allows the user to be touched and dragged on the game screen
			local function dragHero(event)
				local hero = event.target
				local phase = event.phase

				if ("began" == phase) then
					display.currentStage:setFocus(hero)
					hero.touchOffsetX = event.x - hero.x
				elseif ("moved" == phase) then
					hero.x = event.x - hero.touchOffsetX
				elseif("ended" == phase or "cancelled" == phase) then
					display.currentStage:setFocus(nil)
				end
				return true
			end
			hero:addEventListener( "touch", dragHero )

			-- Timers for all the objects being spawned on the screen				
			local regularRockTimer = timer.performWithDelay(1000, spawnRock, 100)
			local smallRockTimer = timer.performWithDelay(800, spawnSmallRock, 100) 
			local bigRockTimer = timer.performWithDelay(1200,spawnBigRock, 100)
			local starTimer = timer.performWithDelay(1200, spawnStar, 100) 

			-- Function that handles all the collisions made by the player and the objects
			-- on the screen
			local function onCollision(event)
				if event.phase == "began" then	
					local obj1 = event.object1
					local obj2 = event.object2

					-- Increments the score when a star is picked up and 
					-- gives the rate at which the stars spawn
					if obj1.type == "powerUp" and obj2.type == "hero" then
						--print("powerUp")
						scoreTF.text = tostring(tonumber(scoreTF.text) + 1)
						-- After collecting the star, it is removed from the screen
						local hideObject = function() 
							obj1.isBodyActive = false
							obj1.isVisible = false
						end
						timer.performWithDelay(1, hideObject, 1) 
					end 
					
					-- If the user is hit by a rock the game ends and the 
					-- end game message is displayed
					if obj1.type == "rock" and obj2.type == "hero" then
						Runtime:removeEventListener("collision", hero)
						--print("Rock")
						obj1.isVisible = false
						timer.performWithDelay(1500,timer.cancel(regularRockTimer))
						timer.performWithDelay(1500,timer.cancel(smallRockTimer))
						timer.performWithDelay(1500,timer.cancel(bigRockTimer))
						timer.performWithDelay(1500,timer.cancel(starTimer))
						timer.performWithDelay(500,gameOver)
						timer.performWithDelay(10,endGame)
					end
					
					-- If the user is hit by a small rock the game ends and the 
					-- end game message is displayed
					if obj1.type == "smallRock" and obj2.type == "hero" then
						Runtime:removeEventListener("collision", hero)
						--print("Small Rock")
						obj1.isVisible = false
						timer.performWithDelay(1500,timer.cancel(regularRockTimer))
						timer.performWithDelay(1500,timer.cancel(smallRockTimer))
						timer.performWithDelay(1500,timer.cancel(bigRockTimer))
						timer.performWithDelay(1500,timer.cancel(starTimer))
						timer.performWithDelay(500,gameOver)
						timer.performWithDelay(10,endGame)
					end
					
					-- If the user is hit by a big rock the game ends and the 
					-- end game message is displayed
					if obj1.type == "bigRock" and obj2.type == "hero" then
						Runtime:removeEventListener("collision", hero)
						--print("Big Rock")
						obj1.isVisible = false
						timer.performWithDelay(1500,timer.cancel(regularRockTimer))
						timer.performWithDelay(1500,timer.cancel(smallRockTimer))
						timer.performWithDelay(1500,timer.cancel(bigRockTimer))
						timer.performWithDelay(1500,timer.cancel(starTimer))
						timer.performWithDelay(500, gameOver)
						timer.performWithDelay(10, endGame)
					end

					-- If the user has collected 10 stars, the game speeds up
					if scoreTF.text == '10' then
						--print("SPEEDING UP!")
						timer.performWithDelay(1500,timer.cancel(regularRockTimer))
						timer.performWithDelay(1500,timer.cancel(smallRockTimer))
						timer.performWithDelay(1500,timer.cancel(bigRockTimer))
						timer.performWithDelay(1500,timer.cancel(starTimer))

						regularRockTimer = timer.performWithDelay(800, spawnRock, 100)
						smallRockTimer = timer.performWithDelay(650, spawnSmallRock, 100)
						bigRockTimer = timer.performWithDelay(1000,spawnBigRock, 100)
						starTimer = timer.performWithDelay(1000, spawnStar, 100) 
					end

					-- If the user has collected 20 stars, the game speeds up even more
					if scoreTF.text == '20' then
						--print("SPEEDING UP!")
						timer.performWithDelay(1500,timer.cancel(regularRockTimer))
						timer.performWithDelay(1500,timer.cancel(smallRockTimer))
						timer.performWithDelay(1500,timer.cancel(bigRockTimer))
						timer.performWithDelay(1500,timer.cancel(starTimer))

						regularRockTimer = timer.performWithDelay(550, spawnRock, 100)
						smallRockTimer = timer.performWithDelay(450, spawnSmallRock, 100)
						bigRockTimer = timer.performWithDelay(650,spawnBigRock, 100)
						starTimer = timer.performWithDelay(1000, spawnStar, 100) 
					end

					-- If the user has collected 30 stars, they win and the game ends
					if scoreTF.text == '30' then
						print("CONGRATS YOU WON!")
						timer.performWithDelay(100,timer.cancel(regularRockTimer))
						timer.performWithDelay(100,timer.cancel(smallRockTimer))
						timer.performWithDelay(100,timer.cancel(bigRockTimer))
						timer.performWithDelay(100,timer.cancel(starTimer))
						timer.performWithDelay(20,youwin)
						timer.performWithDelay(20,endGame)
					end
						
				end
			end

			Runtime:addEventListener("collision", onCollision)
		end

		-- Function to spawn the rock
		function spawnRock() 
			local random_x = math.random(0,470 )
			local rock = display.newImageRect("Images/rock.png",40,40)
			rock.x = random_x
			rock.y = -20
			rock.myName = "Regular Rock"
			rock.type = "rock"
			physics.addBody(rock, {density= 3.0, friction=0.5, bounce=0.3})
		end 

		-- Function to spawn the small rock
		function spawnSmallRock() 
			local random_x = math.random(0,470)
			local smallRock = display.newImageRect("Images/rock.png",25,25)
			smallRock.x = random_x
			smallRock.y = -15
			physics.addBody(smallRock, {density= 3.0, friction=0.5, bounce=0.3})
			smallRock.myName = "Small Rock"
			smallRock.type = "smallRock"
		end 

		-- Function to spawn the big rock
		function spawnBigRock() 
			local random_x = math.random(0,470)
			physics.start()
			local bigRock = display.newImageRect("Images/rock.png",65,65)
			bigRock.x = random_x
			bigRock.y = -20
			physics.addBody(bigRock, {density= 3.0, friction=0.5, bounce=0.3})
			bigRock.myName = "Big Rock"
			bigRock.type = "bigRock"
		end 

		-- Function to spawn stars the user collects for points
		function spawnStar()
			local powerUp = display.newImageRect("Images/star.png",20,20) 
			local powerUp_x = math.random(0,470)
			powerUp.x = powerUp_x
			powerUp.y = -15
			physics.addBody(powerUp, {density= 3.0, friction=0.5, bounce=0.3})

			powerUp.myName = "Star"
			powerUp.type = "powerUp"
		end

		-- Function that shows a message when the game is over
		function gameOver()
			alert = display.newImage("Images/gameOver.png")
			alert.x = 245
			alert.y = 75
			transition.from(alert, {time = 500, xScale = 3, yScale = 3})
			finalStar = display.newImage("Images/up.png")
			transition.from(finalStar, {time = 600, xScale = 3, yScale = 3})
			finalStar.x = 220
			finalStar.y = 140
			finalScore = display.newText(scoreTF.text, 275, 150, 'Marker Felt', 30)
			finalScoretext = display.newText('Final Score', 245, 195, 'Marker Felt', 30)
		end 

		-- Function that shows the message if you have won the game
		function youwin()
			alert = display.newImage("Images/gameOver.png")
			alert.x = 245
			alert.y = 75
			transition.from(alert, {time = 500, xScale = 3, yScale = 3})
			finalStar = display.newImage("Images/up.png")
			transition.from(finalStar, {time = 600, xScale = 3, yScale = 3})
			finalStar.x = 220
			finalStar.y = 140
			finalScore = display.newText(scoreTF.text, 275, 150, 'Marker Felt', 30)
			finalScoretext = display.newText('Congratulations You Won!!', 245, 195, 'Marker Felt', 30)
		end 

		-- TODO: Fix so that the end game screen isn't hidden from the user
		-- Function to go to the menu when the game has ended
		function endGame()
			composer.gotoScene("menu")
		end

		-- Function to update the score
		function update()
			scoreTF.text = tostring(tonumber(scoreTF.text) + 1)
		end
	end
end

-- Function to hide the scene 
function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
	elseif ( phase == "did" ) then
   		print("I'm over here")
   		Runtime:removeEventListener("collision", hero)
		physics.pause()
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
	