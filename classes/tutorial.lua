function love.load()

	CURRENT_FILE = "tutorial" -- set current file

	require "classes/SpriteAnimation" -- require the sprite animation plugin class

	-- load font and define it
	mainFont = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 12)
	defaultFont = love.graphics.newFont(12)
	
	-- load the keyboard images
	key1 = love.graphics.newImage("/textures/intro-1/updownleftright130x82.png")
	key2 = love.graphics.newImage("/textures/intro-1/space300x44.png")

	-- load other textures
	title = love.graphics.newImage("/textures/menu/title388x106WHITE.png")
	oldman = love.graphics.newImage("/textures/intro-1/oldman.png")
	key = love.graphics.newImage("/textures/game/key.png")
	sign = love.graphics.newImage("/textures/game/sign.png")
	
	-- Load all of the text to be displayed on the screen when in the tutorial
	text1 = "Welcome to the Tutorial. Press the arrows to navigate."
	text2 = "This will be a short tutorial so that you can master Aventyr."
	text3 = "This is Bjorn. He is old. He will help you throughout the game."
	text4 = "This is you. Your name is Lucas."
	text5 = "Here are some arrow keys."
	text6 = "Use LEFT & RIGHT to move yourself, UP & DOWN to interact."
	text7 = "Here is a space bar."
	text8 = "Use it to jump."
	text9 = "Here is an objective."
	text10 = "Walk near them to collect them."
	text11 = "This is a key."
	text12 = "Pick them up by pressing the UP key."
	text13 = "This is a sign."
	text14 = "Read them by pressing the UP key."
	text15 = "This is the end of the tutorial. Enjoy the game!"

	currenttextdisplay = 1 -- variable for storing the current text being displayed

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

	local x, y = love.mouse.getPosition() -- get mouse position

	love.graphics.setFont(mainFontBig) --  set font
	love.graphics.setColor(255, 255, 255) --  set color
	love.graphics.print("TUTORIAL", 315, 15) -- set heading text and location

	-- draw back to menu text
	if (x > 285) and (x < 525) and (y > 560) and (y < 585) then
		love.graphics.setColor(0, 255, 255)
		love.graphics.print("BACK TO MENU", 290, 560)
	else
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("BACK TO MENU", 290, 560)
	end
	
	-- set the font to a bigger font
	love.graphics.setFont(mainFontBigger)

	-- display the right arrow
	if currenttextdisplay > 14 then
	else
		if (x > 745) and (x < 790) and (y > 550) and (y < 595) then
			love.graphics.setColor(0, 255, 255)
			love.graphics.print(">", 750, 550)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.print(">", 750, 550)
		end
	end

	-- display the left arrow
	if currenttextdisplay > 1 then
		if (x > 10) and (x < 58) and (y > 550) and (y < 595) then
			love.graphics.setColor(0, 255, 255)
			love.graphics.print("<", 15, 550)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.print("<", 15, 550)
		end
	end

	-- change font for main tut text
	love.graphics.setFont(mainFont)
	love.graphics.setColor(255, 255, 255)

	-- display the main tutorial text
	if currenttextdisplay == 1 then
		love.graphics.print(text1, 145, 450)
	elseif currenttextdisplay == 2 then
		love.graphics.draw(title, 206, 250) 
		love.graphics.print(text2, 120, 450)
	elseif currenttextdisplay == 3 then
		love.graphics.draw(oldman, 368, 300)
		love.graphics.print(text3, 115, 450)
	elseif currenttextdisplay == 4 then
		playerSprites:draw(384, 332)
		love.graphics.print(text4, 250, 450)
	elseif currenttextdisplay == 5 then
		love.graphics.draw(key1, 335, 320)
		love.graphics.print(text5, 280, 450)
	elseif currenttextdisplay == 6 then
		love.graphics.draw(key1, 335, 320)
		love.graphics.print(text6, 145, 450)
	elseif currenttextdisplay == 7 then
		love.graphics.draw(key2, 250, 350)
		love.graphics.print(text7, 305, 450)
	elseif currenttextdisplay == 8 then
		love.graphics.draw(key2, 250, 350)
		love.graphics.print(text8, 325, 450)
	elseif currenttextdisplay == 9 then
		itemSprites:draw(384, 332)
		love.graphics.print(text9, 300, 450)
	elseif currenttextdisplay == 10 then
		itemSprites:draw(384, 332)
		love.graphics.print(text10, 250, 450)
	elseif currenttextdisplay == 11 then
		love.graphics.draw(key, 384, 332)
		love.graphics.print(text11, 335, 450)
	elseif currenttextdisplay == 12 then
		love.graphics.draw(key, 384, 332)
		love.graphics.print(text12, 235, 450)
	elseif currenttextdisplay == 13 then
		love.graphics.draw(sign, 384, 332)
		love.graphics.print(text13, 330, 450)
	elseif currenttextdisplay == 14 then
		love.graphics.draw(sign, 384, 332)
		love.graphics.print(text14, 240, 450)
	elseif currenttextdisplay == 15 then
		love.graphics.print(text15, 175, 450)
	end

	-- display the step out of /15 in the top right
	love.graphics.print(currenttextdisplay.."/15", 740, 5)

	-- displaying debug info in top left corner
	if DISPLAY_DEBUG == true then
		love.graphics.setFont(defaultFont)
		love.graphics.setColor(255, 255, 255)
		fps = love.timer.getFPS( )
		love.graphics.print("Aventyr-tutorial.lua(1.0) LOVE: 0.8.0", 5, 5)
		love.graphics.print("FPS: "..fps, 5, 20)
		love.graphics.print("VARIABLES:", 5, 50)
		if ctrldown == true then
			love.graphics.print("ctrldown = TRUE", 5, 65)
		else
			love.graphics.print("ctrldown = FALSE", 5, 65)
		end
		love.graphics.print("currenttextdisplay: "..currenttextdisplay, 5, 80)
		love.graphics.print("GLOBAL VARIABLES:", 5, 110)
		love.graphics.print("CURRENT_LEVEL: "..CURRENT_LEVEL, 5, 125)
		love.graphics.print("CURRENT_FILE: "..CURRENT_FILE, 5, 140)
		if MUSIC_STATUS == true then
			love.graphics.print("MUSIC_STATUS = TRUE", 5, 155)
		else
			love.graphics.print("MUSIC_STATUS = FALSE", 5, 155)
		end
		if DISPLAY_DEBUG == true then
			love.graphics.print("DISPLAY_DEBUG = TRUE", 5, 170)
		else
			love.graphics.print("DISPLAY_DEBUG = FALSE", 5, 170)
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

function love.keyreleased(key)

	-- advance the step if the right key is pressed
	if key == "right" then
		if currenttextdisplay < 15 then
			currenttextdisplay = currenttextdisplay + 1
		else
		end
	end

	-- go back a step if the left key is pressed
	if key == "left" then
		if currenttextdisplay > 1 then
			currenttextdisplay = currenttextdisplay - 1
		else
		end
	end

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


function love.mousepressed(x, y, button)

	-- script fot the clicking of the buttons
	if CURRENT_FILE == "tutorial" then
		if button == "l" then -- left mouse button
			if (x > 285) and (x < 525) and (y > 560) and (y < 585) then
				dofile (menu)
				love.load()
			end
			if currenttextdisplay < 15 then
				if (x > 745) and (x < 790) and (y > 550) and (y < 595) then
					currenttextdisplay = currenttextdisplay + 1
				end
			else
			end
			if currenttextdisplay > 1 then
				if (x > 10) and (x < 58) and (y > 550) and (y < 595) then
					currenttextdisplay = currenttextdisplay - 1
				end
			else
			end
		end
	end

end