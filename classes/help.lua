function love.load()

	CURRENT_FILE = "help" -- set current file

	require "classes/SpriteAnimation" -- require the sprite animation plugin class

	-- load fonts and define them
	mainFont = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 12)
	mainFontBig = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 24)
	mainFontBigger = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 48)
	defaultFont = love.graphics.newFont(12)


	-- load graphics
	key1 = love.graphics.newImage("/textures/intro-1/updownleftright130x82.png")
	key2 = love.graphics.newImage("/textures/intro-1/space300x44.png")
	oldman = love.graphics.newImage("/textures/intro-1/oldman.png")
	key = love.graphics.newImage("/textures/game/key.png")
	sign = love.graphics.newImage("/textures/game/sign.png")

	-- set the background color to black
	love.graphics.setBackgroundColor(0, 0, 0)

	-- Load player animation
    playerSprites = SpriteAnimation:new("textures/game/player.png", 32, 32, 4, 4)
    playerSprites:load(delay)

    -- load item animation
    itemSprites = SpriteAnimation:new("textures/game/item.png", 32, 32, 20, 1)
    itemSprites:load(delay)


    -- variables for storing state of the Control and shift Keys.
	ctrldown = false

end

function love.draw()

	love.graphics.setFont(mainFontBig) --  set font
	love.graphics.setColor(255, 255, 255) --  set color
	love.graphics.print("HELP", 352, 15) -- set heading text and location

	local x, y = love.mouse.getPosition()

	-- draw the moving player sprite
	playerSprites:draw(20, 100)
	love.graphics.draw(oldman, 20, 140)
	love.graphics.draw(key1, 20, 220)
	love.graphics.draw(key2, 20, 320)
	itemSprites:draw(20, 380)
	love.graphics.draw(key, 20, 420)
	love.graphics.draw(sign, 20, 460)

	-- displaying of back to menu text
	if (x > 550) and (x < 780) and (y > 560) and (y < 585) then
		love.graphics.setColor(0, 255, 255)
		love.graphics.print("BACK TO MENU", 550, 560)
	else
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("BACK TO MENU", 550, 560)
	end

	-- displaying of developer text
	if (x > 10) and (x < 215) and (y > 560) and (y < 585) then
		love.graphics.setColor(0, 255, 255)
		love.graphics.print("DEVELOPER", 15, 560)
	else
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("DEVELOPER", 15, 560)
	end

	-- displaying of the arrows and the text for the help file
	love.graphics.setFont(mainFont)
	love.graphics.setColor(255, 255, 255)
	love.graphics.print("<-- This is you. Your name is Lucas.", 100, 112)
	love.graphics.print("<-- This is Bjorn. He is old. He will help you throughout the game.", 100, 165)
	love.graphics.print("<-- Use LEFT & RIGHT to move yourself, UP & DOWN to interact.", 180, 250)
	love.graphics.print("<-- Use the SPACE BAR to jump", 350, 330)
	love.graphics.print("<-- This is an objective, walk near it to collect it.", 100, 395)
	love.graphics.print("<-- This is a key, pick them up by pressing the UP key.", 100, 435)
	love.graphics.print("<-- This is a sign, read them by pressing the UP key.", 100, 475)

	-- displaying debug info in top left corner
	if DISPLAY_DEBUG == true then
		love.graphics.setFont(defaultFont)
		love.graphics.setColor(255, 255, 255)
		fps = love.timer.getFPS( )
		love.graphics.print("Aventyr-help.lua(1.0) LOVE: 0.8.0", 5, 5)
		love.graphics.print("FPS: "..fps, 5, 20)
		love.graphics.print("VARIABLES:", 5, 50)
		if ctrldown == true then
			love.graphics.print("ctrldown = TRUE", 5, 65)
		else
			love.graphics.print("ctrldown = FALSE", 5, 65)
		end
		love.graphics.print("GLOBAL VARIABLES:", 5, 95)
		love.graphics.print("CURRENT_LEVEL: "..CURRENT_LEVEL, 5, 110)
		love.graphics.print("CURRENT_FILE: "..CURRENT_FILE, 5, 125)
		if MUSIC_STATUS == true then
			love.graphics.print("MUSIC_STATUS = TRUE", 5, 140)
		else
			love.graphics.print("MUSIC_STATUS = FALSE", 5, 140)
		end
		if DISPLAY_DEBUG == true then
			love.graphics.print("DISPLAY_DEBUG = TRUE", 5, 155)
		else
			love.graphics.print("DISPLAY_DEBUG = FALSE", 5, 155)
		end
	end
		
end

function love.update(dt)

	-- update the player sprite every tick
	playerSprites:switch(1, 4, 200)
	playerSprites:update(dt)

	-- update the item sprite every tick
	itemSprites:switch(1, 20, 35)
	itemSprites:update(dt)


	-- if any of the ctrl keys are down, set ctrldown to true, otherwise it is false
	if love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl") then
        ctrldown = true
	else
		ctrldown = false
    end

	
end


function love.mousepressed(x, y, button)

	-- script for the advancing to the next files
	if CURRENT_FILE == "help" then
		if button == "l" then -- left mouse button
			if (x > 550) and (x < 780) and (y > 560) and (y < 585) then
				dofile (menu)
				love.load()
			end
			if (x > 10) and (x < 215) and (y > 560) and (y < 585) then
				dofile (developer)
				love.load()
			end
		end
	end
end


function love.keyreleased(key)

	-- if d is pressed, and ctrl is being held down, toggle the visibility of the debug menu
	if key == "d" then
		if ctrldown == true then
			if DISPLAY_DEBUG == true then
				DISPLAY_DEBUG = false
			else
				DISPLAY_DEBUG = true
			end
		end
	end

end

