function love.load()

	-- intially set mouse to invisible
	love.mouse.setVisible(false)

	-- load font and define it
	mainFont = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 20)
	defaultFont = love.graphics.newFont(12)
	
	-- load textures
	title = love.graphics.newImage("/textures/menu/title388x106WHITE.png")
	splash = love.graphics.newImage("/textures/menu/splash.png")
	
	-- define text to display
	text1 = "Alex Price presents"
	
	-- set ctrldown variable
	ctrldown = false
	
	-- set timers
	timer = 0
	colorFade = 0
	
	-- set variables for displaying of elements
	displayText = true
	displayTitle = false

end

function love.draw()

	love.graphics.setFont(mainFont); -- set font to loaded font
	love.graphics.setColor(colorFade, colorFade, colorFade) -- set color to fading color
	love.graphics.print(text1, 400, 500) -- print the text
	
	-- display the title, and flicker it
	if displayTitle == true then
		if flicker == 0 then
			love.graphics.setColor(255, 255, 255)
			love.graphics.draw(splash, 0, 0)
		else
			love.graphics.setColor(0,0,0)
			love.graphics.draw(splash, 0, 0)
		end
	else
	end
	
	-- displaying the debug menu
	if DISPLAY_DEBUG == true then
		love.graphics.setFont(defaultFont)
		love.graphics.setColor(255, 255, 255)
		fps = love.timer.getFPS( )
		love.graphics.print("Aventyr-mainIntro.lua(1.0) LOVE: 0.8.0", 5, 5)
		love.graphics.print("FPS: "..fps, 5, 20)
		love.graphics.print("VARIABLES:", 5, 50)
		if displayText == true then
			love.graphics.print("displayText = TRUE", 5, 65)
		else
			love.graphics.print("displayText = FALSE", 5, 65)
		end
		love.graphics.print("Timer: "..timer, 5, 80)
		love.graphics.print("colorFade: "..colorFade, 5, 95)
		if displayTitle == true then
			love.graphics.print("displayTitle = TRUE", 5, 110)
		else
			love.graphics.print("displayTitle = FALSE", 5, 110)
		end
		love.graphics.print("GLOBAL VARIABLES:", 5, 140)
		love.graphics.print("CURRENT_LEVEL: "..CURRENT_LEVEL, 5, 155)
		love.graphics.print("CURRENT_FILE: "..CURRENT_FILE, 5, 170)
		if MUSIC_STATUS == true then
			love.graphics.print("MUSIC_STATUS = TRUE", 5, 185)
		else
			love.graphics.print("MUSIC_STATUS = FALSE", 5, 185)
		end
		if DISPLAY_DEBUG == true then
			love.graphics.print("DISPLAY_DEBUG = TRUE", 5, 200)
		else
			love.graphics.print("DISPLAY_DEBUG = FALSE", 5, 200)
		end
	end
	
end

function love.update(dt)

	-- check if the left or right ctrl key is down
	if love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl") then
        ctrldown = true
	else
		ctrldown = false
    end	

	timer = timer + 1 -- increase the timer
	
	-- if displayText == true, then run the code below
	if displayText == true then
		if math.mod(timer, 1) == 0 then
			colorFade = colorFade + 1
		end
		if colorFade == 255 then
			displayText = false
		end
	end
	
	-- if the timer is greater than 400 do the following
	if timer > 400 then
		if math.mod(timer, 1) == 0 then
			if colorFade <= 1 then
				colorFade = colorFade
			else
				colorFade = colorFade - 2
			end
			
		end
	end
	
	-- if the timer is greater than 550, display the title
	if timer > 550 then
		displayTitle = true
	end

	-- code for generating random number for the flicker
	flickerNumber = math.random(100)
	if flickerNumber > 95 then
		flicker = 1
	else
		flicker = 0
	end
	
	-- if the timer is greater than 750, advance to the next file, the menu.
	if timer > 750 then
		dofile (menu)
		love.load()
	end
	
end

function love.keyreleased(key)
	
	-- Checks if the "d" key is pressed, then toggles the debug menu
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

