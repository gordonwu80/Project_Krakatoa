-------------
-- File: main.lua
-- Authors: Mordecai Ebhohon and Gordon Wu
-- Description: The first file that is opened once the game is started.
--              It shows the menu and its options 
-------------

local composer = require("composer")

display.setStatusBar (display.HiddenStatusBar)

math.randomseed(os.time())

composer.gotoScene("menu")
