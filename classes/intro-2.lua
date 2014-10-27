function love.load()

	-- intially set mouse to invisible
	love.mouse.setVisible(false)
	
	CURRENT_LEVEL = 3 -- sets current level. 1 = introOne.
	
	-- load fonts and define them
	mainFont = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 12)
	mainFontBig = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 24)
	mainFontBigger = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 48)
	defaultFont = love.graphics.newFont(12)
	
	menuOverlay = love.graphics.newImage("/textures/intro-1/black(75%)800x600.png")
	oldman = love.graphics.newImage("/textures/intro-1/oldman.png")
		
	-- set message text
	text1 = "Excellent job!"
	text2 = "This next one will really test you."
	
	-- define timer
	timer = 0
	
	-- define starting colour of background for fade
	fadecolor = 255

	-- set all texts to not display, will be toggled when needed.
	text1display = false
	text2display = false
	
	-- load the length of the text
	text1length = string.len(text1)
	text2length = string.len(text2)
	
	-- variables for storing the status of the instructions
	nextInstruction = false
	textInstructions = ""
	
	-- set the x and y coordinates for the text. Will be changed based on the length of the text to ensure that it is centered.
	xtextPosition = 0
	ytextPosition = 450
	
	-- keeps track of the current text displaying
	current = 0
    
    -- Whether or not the game is paused
    paused = false
	
	-- variable for storing state of the Control Keys.
	ctrldown = false

	
	-- amount of characters in each message
	text1charcount = text1length - 1
	text2charcount = text2length - 1

	-- variable for the output text
	outputText = ""
	
	-- variable for storing if the text is finished
	textFinish = false
	
	oldmanDisplay = false -- whether the oldman is to be displayed.


end

function love.draw()

	-- get the x and y coordinates of the mouse pointer.
	local x, y = love.mouse.getPosition()

	love.graphics.setFont(mainFont); -- set font to loaded font
	love.graphics.setColor(255, 255, 255) -- set text colour to white
	love.graphics.print(outputText, xtextPosition, ytextPosition)
	love.graphics.print(textInstructions, 725, 5)
	
	-- draw the old man!
	if oldmanDisplay == true then
		love.graphics.draw(oldman, 5, 531)
	else
	end
	
	
	-- if the game is paused, display the paused menu, complete with buttons that change color when you hover on them!
	if paused == true then
		love.graphics.draw(menuOverlay, 0, 0)
		love.graphics.setFont(mainFontBigger)
		love.mouse.setVisible(true) -- set mouse as visible
		local mousex, mousey = love.mouse.getPosition()
		love.graphics.print("PAUSED", 275, 150)
		if (mousex > 320) and (mousex < 460) and (mousey > 250) and (mousey < 275) then
			love.graphics.setColor(0, 255, 255)
			love.graphics.setFont(mainFontBig)
			love.graphics.print("RESUME", 330, 250)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.setFont(mainFontBig)
			love.graphics.print("RESUME", 330, 250)
		end
		if (mousex > 295) and (mousex < 485) and (mousey > 300) and (mousey < 325) then
			love.graphics.setColor(0, 255, 255)
			love.graphics.setFont(mainFontBig)
			love.graphics.print("MAIN MENU", 305, 300)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.setFont(mainFontBig)
			love.graphics.print("MAIN MENU", 305, 300)
		end
	else
	end
	

	-- display the debug information
	if DISPLAY_DEBUG == true then
		love.graphics.setFont(defaultFont)
		love.graphics.setColor(255, 255, 255)
		fps = love.timer.getFPS( )
		love.graphics.print("Aventyr-intro-2.lua(1.0) LOVE: 0.8.0", 5, 5)
		love.graphics.print("FPS: "..fps, 5, 20)
		love.graphics.print("VARIABLES:", 5, 50)
		if ctrldown == true then
			love.graphics.print("ctrldown = TRUE", 5, 65)
		else
			love.graphics.print("ctrldown = FALSE", 5, 65)
		end
		love.graphics.print("timer: "..timer, 5, 80)
		love.graphics.print("fadecolor: "..fadecolor, 5, 95)
		if nextInstruction == true then
			love.graphics.print("nextInstruction = TRUE", 5, 110)
		else
			love.graphics.print("nextInstruction = FALSE", 5, 110)
		end
		love.graphics.print("textInstructions: "..textInstructions, 5, 125)
		love.graphics.print("xtextPosition: "..xtextPosition, 5, 140)
		love.graphics.print("ytextPosition: "..ytextPosition, 5, 155)
		love.graphics.print("current: "..current, 5, 170)
		love.graphics.print("outputText: "..outputText, 5, 185)
		if paused == true then
			love.graphics.print("paused = TRUE", 5, 200)
		else
			love.graphics.print("paused = FALSE", 5, 200)
		end
		if textFinish == true then
			love.graphics.print("textFinish = TRUE", 5, 215)
		else
			love.graphics.print("textFinish = FALSE", 5, 215)
		end
		love.graphics.print("GLOBAL VARIABLES:", 5, 245)
		love.graphics.print("CURRENT_LEVEL: "..CURRENT_LEVEL, 5, 260)
		love.graphics.print("CURRENT_FILE: "..CURRENT_FILE, 5, 275)
		if MUSIC_STATUS == true then
			love.graphics.print("MUSIC_STATUS = TRUE", 5, 290)
		else
			love.graphics.print("MUSIC_STATUS = FALSE", 5, 290)
		end
		if DISPLAY_DEBUG == true then
			love.graphics.print("DISPLAY_DEBUG = TRUE", 5, 305)
		else
			love.graphics.print("DISPLAY_DEBUG = FALSE", 5, 305)
		end
	end
	
	
end

function love.update ()

	-- if the game is not paused, do a fade in effect for the background.
	if paused == false then
		if fadecolor > 0 then
			fadecolor = fadecolor - 1	
		end
	end

	-- set the background color
	love.graphics.setBackgroundColor(fadecolor, fadecolor, fadecolor)

	-- display the (SPACE) message if the text is ready to be skipped
	if nextInstruction == true then
		textInstructions = "(SPACE)"
	else
		textInstructions = ""
	end
	
	-- if the fadecolor is done, do the following
	if fadecolor == 1 then
		text1display = true
		fadecolor = 0
		oldmanDisplay = true
	end

	-- if any of the ctrl keys are down, change the variable below
	if love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl") then
        ctrldown = true
	else
		ctrldown = false
    end
	
	-- if the game is paused, don't increment the timer, otherwise increment it.
	if paused == true then
		timer = timer
	else
		timer = timer + 1
	end
	
	-- displaying of the scrolling text
	if text1display == true then
		if math.mod(timer, 5) == 0 then
			outputText = string.sub(text1, 1, -text1charcount).."_"
			text1charcount = text1charcount - 1
			xtextPosition = 340
			if text1charcount == 0 then
				text1display = false
				nextInstruction = true
				current = 1
			end			
		end
	end
	
	-- displaying of the scrolling text
	if text2display == true then
		if math.mod(timer, 5) == 0 then
			outputText = string.sub(text2, 1, -text2charcount).."_"
			text2charcount = text2charcount - 1
			xtextPosition = 225
			if text2charcount == 0 then
				text2display = false
				nextInstruction = true
				current = 2
			end			
		end
	end
	
	-- if the text is finished, start the second game
	if textFinish ==  true then
		dofile (gameTwo)
		love.load()
	end
	
end

function love.keyreleased(key)

	-- pause the intro if the escape key is pressed
	if key == "escape" then
		if paused == false then
			paused = true
			love.mouse.setVisible(true)
		else
			paused = false
			love.mouse.setVisible(false)
		end
    end
	
	-- toggling the debug menu
	if key == "d" then
		if ctrldown == true then
			if DISPLAY_DEBUG == true then
				DISPLAY_DEBUG = false
			else
				DISPLAY_DEBUG = true
			end
		end
	end
	
	-- if the key (space) is pressed, then skip to the next file.
	if key == " " then
		if paused == false then
			if nextInstruction == true then
				if current == 1 then
					text2display = true
					nextInstruction = false
				end
				if current == 2 then
					text3display = true
					nextInstruction = false
					outputText = ""
					textFinish = true
				end
			end
		else
		end
	end
end

-- function for pressing of mouse
function love.mousepressed(x, y, button)
	if paused == true then
		-- coordinates of the resume button
		if (x > 320) and (x < 460) and (y > 250) and (y < 275) then
			if button == "l" then
				paused = false
			end
		end
		-- coordinates of the menu button
		if (x > 295) and (x < 485) and (y > 300) and (y < 325) then
			if button == "l" then
				dofile (menu)
				love.load()
			end
		end				
	end
end