function love.load()

	CURRENT_FILE = "settings" -- set current file

	-- load fonts and define them
	mainFont = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 12)
	mainFontBig = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 24)
	mainFontBigger = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 48)
	defaultFont = love.graphics.newFont(12)


	-- set the background color to black
	love.graphics.setBackgroundColor(0, 0, 0)


	-- variables for storing state of the Control and shift Keys.
	ctrldown = false

end

function love.draw()

	local x, y = love.mouse.getPosition()

	love.graphics.setFont(mainFontBig) --  set font
	love.graphics.setColor(255, 255, 255) --  set color
	love.graphics.print("SETTINGS", 315, 15) -- set heading text and location

	if (x > 285) and (x < 525) and (y > 560) and (y < 585) then
		love.graphics.setColor(0, 255, 255)
		love.graphics.print("BACK TO MENU", 290, 560)
	else
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("BACK TO MENU", 290, 560)
	end

	love.graphics.setColor(255, 255, 255)
	love.graphics.print("MAIN MENU SOUND:", 15, 100)

	if MUSIC_STATUS == false then
		if (x > 335) and (x < 475) and (y > 100) and (y < 125) then
			love.graphics.setColor(0, 255, 255)
			love.graphics.print("Disabled", 335, 100)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.print("Disabled", 335, 100)
		end
	else
		if (x > 335) and (x < 475) and (y > 100) and (y < 125) then
			love.graphics.setColor(0, 255, 255)
			love.graphics.print("Enabled", 335, 100)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.print("Enabled", 335, 100)
		end
	end

	-- displaying debug info in top left corner
	if DISPLAY_DEBUG == true then
		love.graphics.setFont(defaultFont)
		love.graphics.setColor(255, 255, 255)
		fps = love.timer.getFPS( )
		love.graphics.print("Aventyr-settings.lua(1.0) LOVE: 0.8.0", 5, 5)
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

function love.update()

	-- if any of the ctrl keys are down, set ctrldown to true, otherwise it is false
	if love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl") then
        ctrldown = true
	else
		ctrldown = false
    end
	
end


function love.mousepressed(x, y, button)

	if CURRENT_FILE == "settings" then
		if button == "l" then -- left mouse button
			if (x > 285) and (x < 525) and (y > 560) and (y < 585) then
				dofile (menu)
				love.load()
			end
			if (x > 335) and (x < 475) and (y > 100) and (y < 125) then
				if MUSIC_STATUS == true then
					MUSIC_STATUS = false
					love.audio.pause()
				else
					MUSIC_STATUS = true
					love.audio.resume()
				end
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