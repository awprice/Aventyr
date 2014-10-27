function love.load()

	-- intially set mouse to invisible
	love.mouse.setVisible(false)
	
	CURRENT_LEVEL = 1 -- sets current level. 1 = introOne.
	
	-- load fonts and define them
	mainFont = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 12)
	mainFontBig = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 24)
	mainFontBigger = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 48)
	defaultFont = love.graphics.newFont(12)
	
	-- load textures
	key1 = love.graphics.newImage("/textures/intro-1/updownleftright130x82.png")
	key2 = love.graphics.newImage("/textures/intro-1/space300x44.png")
	menuOverlay = love.graphics.newImage("/textures/intro-1/black(75%)800x600.png")
	oldman = love.graphics.newImage("/textures/intro-1/oldman.png")
	
	-- load the glitching textures
	glitch0 = love.graphics.newImage("/textures/intro-1/glitch0.png")
	glitch1 = love.graphics.newImage("/textures/intro-1/glitch1.png")
	glitch2 = love.graphics.newImage("/textures/intro-1/glitch2.png")
	glitch3 = love.graphics.newImage("/textures/intro-1/glitch3.png")
	glitch4 = love.graphics.newImage("/textures/intro-1/glitch4.png")
	glitch5 = love.graphics.newImage("/textures/intro-1/glitch5.png")
	glitch6 = love.graphics.newImage("/textures/intro-1/glitch6.png")
	glitch7 = love.graphics.newImage("/textures/intro-1/glitch7.png")
	glitch8 = love.graphics.newImage("/textures/intro-1/glitch8.png")
	glitch9 = love.graphics.newImage("/textures/intro-1/glitch9.png")
	glitch10 = love.graphics.newImage("/textures/intro-1/glitch10.png")
	
	-- set the status
	randomImage = false
		
	-- set message text
	text1 = "Hello Lucas!"
	text2 = "Welcome to Aventyr!"
	text3 = "This is a game of adventure and skill."
	text4 = "You will face great moments of triumph and disappointment."
	text5 = "This adventure will scar you for life."
	text6 = "LOL jks no."
	text7 = "Enough chit-chat. Time for some controls."
	text8 = "Use LEFT & RIGHT to move yourself, UP & DOWN to interact."
	text9 = "Use SPACE to jump."
	text10 = "That is all. A world awaits..."
	text11 = "WHAT THE??fds;lknfgj jjs.d.f.... ERR:412 script.time.out/aventyr.."
	
	-- define timer
	timer = 0
	timer2 = 0
	
	-- define starting colour of background for fade
	fadecolor = 255

	-- set all texts to not display, will be toggled when needed.
	text1display = false
	text2display = false
	text3display = false
	text4display = false
	text5display = false
	text6display = false
	text7display = false
	text8display = false
	text9display = false
	text10display = false
	text11display = false
	
	-- load the length of the text
	text1length = string.len(text1)
	text2length = string.len(text2)
	text3length = string.len(text3)
	text4length = string.len(text4)
	text5length = string.len(text5)
	text6length = string.len(text6)
	text7length = string.len(text7)
	text8length = string.len(text8)
	text9length = string.len(text9)
	text10length = string.len(text10)
	text11length = string.len(text11)
	
	-- variables for storing the status of the instructions
	nextInstruction = false
	textInstructions = ""
	
	-- set the x and y coordinates for the text. Will be changed based on the length of the text to ensure that it is centered.
	xtextPosition = 0
	ytextPosition = 450
	
	-- keeps track of the current text displaying
	current = 0
	
	-- Variables for storing the status of whether the control images are displaying.
	imageDisplay1 = false
	imageDisplay2 = false
    
    -- Whether or not the game is paused
    paused = false
	
	-- variable for storing state of the Control Keys.
	ctrldown = false

	
	-- amount of characters in each message
	text1charcount = text1length - 1
	text2charcount = text2length - 1
	text3charcount = text3length - 1
	text4charcount = text4length - 1
	text5charcount = text5length - 1
	text6charcount = text6length - 1
	text7charcount = text7length - 1
	text8charcount = text8length - 1
	text9charcount = text9length - 1
	text10charcount = text10length - 1
	text11charcount = text11length - 1

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
	
	-- if imagedisplay1 is true then display the image
	if imageDisplay1 == true then
		love.graphics.draw(key1, 335, 320)
	else
	end
	
	-- if imagedisplay2 is true then display the image
	if imageDisplay2 == true then
		love.graphics.draw(key2, 250, 350)
	else
	end
	
	-- draw the old man!
	if oldmanDisplay == true then
		love.graphics.draw(oldman, 5, 531)
	else
	end
	
	-- for displaying the glitching textures
	if textFinish == true then
		if paused == false then
			if randomImage == true then
				if imagePicker ==  0 then
					love.graphics.draw(glitch1, 0, 0)
				elseif imagePicker ==  1 then
					love.graphics.draw(glitch2, 0, 0)
				elseif imagePicker ==  2 then
					love.graphics.draw(glitch3, 0, 0)
				elseif imagePicker ==  3 then
					love.graphics.draw(glitch4, 0, 0)
				elseif imagePicker ==  4 then
					love.graphics.draw(glitch5, 0, 0)
				elseif imagePicker ==  5 then
					love.graphics.draw(glitch6, 0, 0)
				elseif imagePicker ==  6 then
					love.graphics.draw(glitch7, 0, 0)
				elseif imagePicker ==  7 then
					love.graphics.draw(glitch8, 0, 0)
				elseif imagePicker ==  8 then
					love.graphics.draw(glitch9, 0, 0)
				elseif imagePicker ==  9 then
					love.graphics.draw(glitch10, 0, 0)
				end
			else
				love.graphics.draw(glitch0, 0, 0)
			end
		else
			love.graphics.draw(glitch0, 0, 0)
		end
	else
	end
	
	
	-- if the game is paused, display the paused menu, complete with buttons that change color when you hover on them!
	if paused == true then
		love.graphics.draw(menuOverlay, 0, 0)
		love.mouse.setVisible(true) -- set mouse as visible
		love.graphics.setFont(mainFontBigger)
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
		love.graphics.print("Aventyr-intro-1.lua(1.0) LOVE: 0.8.0", 5, 5)
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
		if imageDisplay1 == true then
			love.graphics.print("imageDisplay1 = TRUE", 5, 185)
		else
			love.graphics.print("imageDisplay1 = FALSE", 5, 185)
		end
		if imageDisplay2 == true then
			love.graphics.print("imageDisplay2 = TRUE", 5, 200)
		else
			love.graphics.print("imageDisplay2 = FALSE", 5, 200)
		end
		love.graphics.print("outputText: "..outputText, 5, 215)
		if paused == true then
			love.graphics.print("paused = TRUE", 5, 230)
		else
			love.graphics.print("paused = FALSE", 5, 230)
		end
		if textFinish == true then
			love.graphics.print("textFinish = TRUE", 5, 245)
		else
			love.graphics.print("textFinish = FALSE", 5, 245)
		end
		love.graphics.print("timer2: "..timer2, 5, 260)
		love.graphics.print("GLOBAL VARIABLES:", 5, 290)
		love.graphics.print("CURRENT_LEVEL: "..CURRENT_LEVEL, 5, 305)
		love.graphics.print("CURRENT_FILE: "..CURRENT_FILE, 5, 320)
		if MUSIC_STATUS == true then
			love.graphics.print("MUSIC_STATUS = TRUE", 5, 335)
		else
			love.graphics.print("MUSIC_STATUS = FALSE", 5, 335)
		end
		if DISPLAY_DEBUG == true then
			love.graphics.print("DISPLAY_DEBUG = TRUE", 5, 350)
		else
			love.graphics.print("DISPLAY_DEBUG = FALSE", 5, 350)
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
			xtextPosition = 300
			if text2charcount == 0 then
				text2display = false
				nextInstruction = true
				current = 2
			end			
		end
	end
	
	-- displaying of the scrolling text
	if text3display == true then
		if math.mod(timer, 5) == 0 then
			outputText = string.sub(text3, 1, -text3charcount).."_"
			text3charcount = text3charcount - 1
			xtextPosition = 215
			if text3charcount == 0 then
				text3display = false
				nextInstruction = true
				current = 3
			end			
		end
	end

	-- displaying of the scrolling text
	if text4display == true then
		if math.mod(timer, 5) == 0 then
			outputText = string.sub(text4, 1, -text4charcount).."_"
			text4charcount = text4charcount - 1
			xtextPosition = 100
			if text4charcount == 0 then
				text4display = false
				nextInstruction = true
				current = 4
			end			
		end
	end
	
	-- displaying of the scrolling text
	if text5display == true then
		if math.mod(timer, 5) == 0 then
			outputText = string.sub(text5, 1, -text5charcount).."_"
			text5charcount = text5charcount - 1
			xtextPosition = 215
			if text5charcount == 0 then
				text5display = false
				nextInstruction = true
				current = 5
			end			
		end
	end
	
	-- displaying of the scrolling text
	if text6display == true then
		if math.mod(timer, 5) == 0 then
			outputText = string.sub(text6, 1, -text6charcount).."_"
			text6charcount = text6charcount - 1
			xtextPosition = 350
			if text6charcount == 0 then
				text6display = false
				nextInstruction = true
				current = 6
			end			
		end
	end

	-- displaying of the scrolling text
	if text7display == true then
		if math.mod(timer, 5) == 0 then
			outputText = string.sub(text7, 1, -text7charcount).."_"
			text7charcount = text7charcount - 1
			xtextPosition = 205
			if text7charcount == 0 then
				text7display = false
				nextInstruction = true
				current = 7
			end			
		end
	end
	
	-- displaying of the scrolling text
	if text8display == true then
		if math.mod(timer, 5) == 0 then
			outputText = string.sub(text8, 1, -text8charcount).."_"
			text8charcount = text8charcount - 1
			imageDisplay1 = true
			xtextPosition = 110
			if text8charcount == 0 then
				text8display = false
				nextInstruction = true
				current = 8
			end			
		end
	end

	-- displaying of the scrolling text
	if text9display == true then
		if math.mod(timer, 5) == 0 then
			outputText = string.sub(text9, 1, -text9charcount).."_"
			text9charcount = text9charcount - 1
			imageDisplay2 = true
			xtextPosition = 310
			if text9charcount == 0 then
				text9display = false
				nextInstruction = true
				current = 9
			end			
		end
	end
	
	-- displaying of the scrolling text
	if text10display == true then
		if math.mod(timer, 5) == 0 then
			outputText = string.sub(text10, 1, -text10charcount).."_"
			text10charcount = text10charcount - 1
			xtextPosition = 250
			if text10charcount == 0 then
				text10display = false
				nextInstruction = true
				current = 10
			end			
		end
	end
	
	-- displaying of the scrolling text
	if text11display == true then
		if math.mod(timer, 5) == 0 then
			outputText = string.sub(text11, 1, -text11charcount).."_"
			text11charcount = text11charcount - 1
			xtextPosition = 75
			if text11charcount == 0 then
				text11display = false
				nextInstruction = true
				current = 11
			end			
		end
	end
	
	-- glitching random image script
	randomGlitch = math.random(150)
	if randomGlitch > 100 then
		randomImage = true
	else
		randomImage = false
	end
	
	-- random function for displaying of random image
	imagePicker = math.random(9)
	
	-- if the text is finished, start the second timer
	if textFinish == true then
		timer2 = timer2 + 1
	end
	
	-- when timer2 == 150 then start the next level, gameOne.
	if timer2 ==  150 then
		dofile (gameOne)
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
				end
				if current == 3 then
					text4display = true
					nextInstruction = false
				end
				if current == 4 then
					text5display = true
					nextInstruction = false
				end
				if current == 5 then
					text6display = true
					nextInstruction = false
				end
				if current == 6 then
					text7display = true
					nextInstruction = false
				end
				if current == 7 then
					text8display = true
					nextInstruction = false
				end
				if current == 8 then
					text9display = true
					nextInstruction = false
					imageDisplay1 = false
				end
				if current == 9 then
					text10display = true
					nextInstruction = false
					imageDisplay2 = false
				end
				if current == 10 then
					text11display = true
					nextInstruction = false
				end
				if current == 11 then
					text11display = false
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