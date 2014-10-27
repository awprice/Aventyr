function love.load()

	CURRENT_FILE = "menu" -- set current file
	
	-- set mouse as visible
	love.mouse.setVisible(true)	
	
	-- loading graphics
	background = love.graphics.newImage("/textures/menu/background800x600.png")
	title = love.graphics.newImage("/textures/menu/title388x106WHITE.png")
	shadow = love.graphics.newImage("/textures/menu/shadow1600x1200.png")
	black = love.graphics.newImage("/textures/menu/black1600x1200.png")
	
	-- load and assign fonts
	mainFont = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 12) -- load font and assign it to mainFont
	mainFontBig = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 24) -- Double the size!
	mainFontBigger = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 48) -- Even bigger!
	defaultFont = love.graphics.newFont(12) -- set the default font to defaultFont
	
	-- background sounds
	bgm = love.audio.newSource("/sounds/menu/bgm.mp3", "stream") -- load background music
	if MUSIC_STATUS == true then -- if the global variable MUSIC_STATUS is true then play the music. Can be changed in the settings menu.
		love.audio.play(bgm) -- play on menu load
	else
	end
	
	-- variables for storing state of the Control and shift Keys.
	ctrldown = false
	shiftdown = false

end
function love.draw()
	-- set default font
	love.graphics.setFont(defaultFont)
	
	-- get the x and y coordinates of the mouse pointer.
	local x, y = love.mouse.getPosition()
	
	love.graphics.draw(background, 0, 0) -- insert static background
	love.graphics.setColor(255, 255, 255) -- set the active color
    love.graphics.print("1.0", 5, 585) -- fixed, visible version number of the game
	love.graphics.draw(title, 206, 50) -- insert static title
	
	love.graphics.setFont(mainFontBig) --  set font for menu
	
	-- draw resume game menu option
	if CURRENT_LEVEL ~= 0 then
		if (x > 265) and (x < 510) and (y > 250) and (y < 275) then
			love.graphics.setColor(0, 255, 255)
			love.graphics.print("RESUME GAME", 275, 250)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.print("RESUME GAME", 275, 250)
		end
	else
	end
	
	-- draw new game menu option
	if (x > 298) and (x < 475) and (y > 300) and (y < 325) then
		love.graphics.setColor(0, 255, 255)
		love.graphics.print("NEW GAME", 308, 300)
	else
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("NEW GAME", 308, 300)
	end
	
	-- draw settings menu option
	if (x > 298) and (x < 470) and (y > 350) and (y < 375) then
		love.graphics.setColor(0, 255, 255)
		love.graphics.print("SETTINGS", 308, 350)
	else
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("SETTINGS", 308, 350)
	end
	
	-- draw tutorial menu option
	if (x > 340) and (x < 435) and (y > 400) and (y < 425) then
		love.graphics.setColor(0, 255, 255)
		love.graphics.print("TUTORIAL", 308, 400)
	else
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("TUTORIAL", 308, 400)
	end
	
	-- draw help menu option
	if (x > 342) and (x < 430) and (y > 450) and (y < 475) then
		love.graphics.setColor(0, 255, 255)
		love.graphics.print("HELP", 352, 450)
	else
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("HELP", 352, 450)
	end

	-- draw exit menu option
	if (x > 342) and (x < 430) and (y > 500) and (y < 525) then
		love.graphics.setColor(0, 255, 255)
		love.graphics.print("EXIT", 352, 500)
	else
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("EXIT", 352, 500)
	end
	
	love.graphics.setColor(255, 255, 255) -- reset draw color back to white
   
   -- center coordinates for shadow
    x1 = x - 800
    y2 = y - 600
	
	-- flickering shadow
	if flicker == 0 then
		love.graphics.draw(shadow, x1, y2)
	else
		love.graphics.draw(black, x1, y2)
    end
	
	-- displaying debug info in top left corner
	if DISPLAY_DEBUG == true then
		love.graphics.setFont(defaultFont)
		love.graphics.setColor(255, 255, 255)
		fps = love.timer.getFPS( )
		love.graphics.print("Aventyr-menu.lua(1.0) LOVE: 0.8.0", 5, 5)
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

	-- continually set mouse to visible, due to game -> menu glitch
	love.mouse.setVisible(true)	

	-- random function for flickering shadow
	flickerNumber = math.random(100)
	if flickerNumber > 95 then
		flicker = 1
	else
		flicker = 0
	end
	
	-- if any of the ctrl keys are down, set ctrldown to true, otherwise it is false
	if love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl") then
        ctrldown = true
	else
		ctrldown = false
    end
	
	-- if the left or right shift is held down, set shiftdown to true.
	if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then 
		shiftdown = true
	else
		shiftdown = false
	end

end

-- function for pressing of mouse
function love.mousepressed(x, y, button)

if CURRENT_FILE == "menu" then

	if button == "l" then -- left mouse button
		if CURRENT_LEVEL ~= 0 then
			if (x > 265) and (x < 510) and (y > 250) and (y < 275) then -- resume game button
				if CURRENT_LEVEL == 1 then -- go to scene 1 (intro 1)
					love.audio.stop()
					dofile (introOne)
					love.load()
				end
				if CURRENT_LEVEL == 2 then --  go to scene 2 (game 1)
					love.audio.stop()
					dofile (gameOne)
					love.load()
				end
				if CURRENT_LEVEL == 3 then -- go to scene 3 (intro 2)
					love.audio.stop()
					dofile (introTwo)
					love.load()
				end
				if CURRENT_LEVEL == 4 then --  go to scene 4 (game 2)
					love.audio.stop()
					dofile (gameTwo)
					love.load()
				end
				if CURRENT_LEVEL == 5 then --  go to scene 5 (intro 3)
					love.audio.stop()
					dofile (outro)
					love.load()
				end
			end
		end		
		if (x > 298) and (x < 475) and (y > 300) and (y < 325) then -- new game button, load the first level (introOne)
			love.audio.stop()
			dofile (introOne)
			love.load()
		end
		if (x > 298) and (x < 470) and (y > 350) and (y < 375) then -- if the settings button is clicked, then load the settings menu.
			dofile(settings)
			love.load()
		end
		if (x > 340) and (x < 435) and (y > 400) and (y < 425) then -- if the tutorial button is clicked, then load the tutorial menu.
			dofile(tutorial)
			love.load()
		end
		if (x > 342) and (x < 430) and (y > 450) and (y < 475) then -- if the help button is clicked, then load the help menu.
			dofile(help)
			love.load()
		end	
		if (x > 342) and (x < 430) and (y > 500) and (y < 525) then -- if the exit button is clicked, then exit the game.
			quit() 
		end
	end
end
	
end

function love.keyreleased(key)
	-- if escape is pressed, close the game
    if key == "escape" then
        quit()   -- causes the game to quit
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