function love.load()

	CURRENT_FILE = "developer" -- set current file

	-- load fonts and define them
	mainFont = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 12)
	mainFontBig = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 24)
	mainFontBigger = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 48)
	defaultFont = love.graphics.newFont(12)

	-- load textures
	title = love.graphics.newImage("/textures/menu/title388x106WHITE.png")
	lclogo = love.graphics.newImage("/textures/menu/lclogo.png")

	-- set the background color to black
	love.graphics.setBackgroundColor(0, 0, 0)

	-- variables for storing state of the Control and shift Keys.
	ctrldown = false


end

function love.draw()

	love.graphics.setFont(mainFontBig) --  set font
	love.graphics.setColor(255, 255, 255) --  set color

	love.graphics.draw(title, 206, 50) -- insert static title
	love.graphics.draw(lclogo, 335, 280, 0, 0.25, 0.25) -- insert lc logo
	love.graphics.setFont(defaultFont)
	love.graphics.print("Developed and Created by Alex Price", 280, 200) -- set heading text and location
	love.graphics.print("For issues, queries and other comments/questions, please contact the Developer at:", 135, 240) -- set heading text and location
	love.graphics.print("support@legendcraft.co", 315, 260) -- set heading text and location

	local x, y = love.mouse.getPosition()

	love.graphics.setFont(mainFontBig) --  set font
	love.graphics.setColor(255, 255, 255) --  set color

	-- for displaying the back to menu button
	if (x > 550) and (x < 780) and (y > 560) and (y < 585) then
		love.graphics.setColor(0, 255, 255)
		love.graphics.print("BACK TO MENU", 550, 560)
	else
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("BACK TO MENU", 550, 560)
	end

	-- displaying debug info in top left corner
	if DISPLAY_DEBUG == true then
		love.graphics.setFont(defaultFont)
		love.graphics.setColor(255, 255, 255)
		fps = love.timer.getFPS( )
		love.graphics.print("Aventyr-developer.lua(1.0) LOVE: 0.8.0", 5, 5)
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

	-- if any of the ctrl keys are down, set ctrldown to true, otherwise it is false
	if love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl") then
        ctrldown = true
	else
		ctrldown = false
    end
	
end


function love.mousepressed(x, y, button)

	-- script for the going to page when a page is pressed
	if CURRENT_FILE == "developer" then
		if button == "l" then -- left mouse button
			if (x > 550) and (x < 780) and (y > 560) and (y < 585) then
				dofile (menu)
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