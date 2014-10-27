require "classes/Player"
require "classes/SpriteAnimation"
require "classes/camera"

function love.load()

	love.mouse.setVisible(false) -- set mouse as invisible
	love.mouse.setGrab(true) -- lock mouse in window
	
	CURRENT_LEVEL = 4

    width = love.graphics.getWidth() -- get width of game window
    height = love.graphics.getHeight() -- get height of game window
    love.graphics.setBackgroundColor(0, 0, 0) --  set background color
	
	mainFont = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 12) -- load font and assign it to mainFont
	mainFontBig = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 24) -- Double the size!
	mainFontBigger = love.graphics.newFont("/textures/fonts/C64_Pro_v1.0-STYLE.ttf", 48) -- Even bigger!
	defaultFont = love.graphics.newFont(12) -- set the default font to defaultFont
	
	shadow = love.graphics.newImage("/textures/game/shadow1600x1200.png") -- load the shadow 
	backgroundLayer = love.graphics.newImage("/textures/game/background1600x1200.png") -- load the background layer
	overlay = love.graphics.newImage("/textures/game/black(75%)800x600.png") -- load the overlay
	
	laserOn = love.graphics.newImage("/textures/game/laser2.png") -- load laseron sprite
	laserOff = love.graphics.newImage("/textures/game/laser1.png") -- load laseroff sprite
	tile1 = love.graphics.newImage("/textures/game/tile1.png") -- load tile sprite
	

	key = love.graphics.newImage("/textures/game/key.png") -- load key sprite
    
    -- Load up the map
    loader = require("AdvTiledLoader.Loader")
    loader.path = "textures/game/"
    map = loader.load("map02.tmx")
    map:setDrawRange(0, 0, map.width * map.tileWidth, map.height * map.tileHeight)
    
    -- restrict the camera
    camera:setBounds(0, 0, map.width * map.tileWidth - width, map.height * map.tileHeight - height)
    
    p = Player:new() -- create a new player
    
    p.x = 1552 -- player's starting x coordinate
    p.y = 900 -- player's starting y coordinate
    p.width = 32 -- width of the player
    p.height = 32 -- height of the player
    p.jumpSpeed = -800 -- the player's jumping speed
    p.runSpeed = 500 -- the player's run speed
    
    gravity = 1800 -- amount of gravity
    hasJumped = false
    delay = 120
    
    -- Load player animation
    playerSprites = SpriteAnimation:new("textures/game/player.png", 32, 32, 4, 4)
    playerSprites:load(delay)
    
	paused = false --  whether the game is paused
	text1display = false -- whether text1 is displaying
	signRead = false -- whether the sign has been read
	
	text1 = "SIGN: Complete the level." -- text1's contents
	timer = 0 --  the timer for the reading of the signs.
	text1length = string.len(text1)  -- get the length of text1
	text1charcount = text1length - 1 --  take away one for the extra _ at the end
	outputText = "" -- set the output text
	done = false --  whether the sign has been read and the text has finished displaying
	
	ctrldown = false
	shiftdown = false
	
	movingBlock1y = 960
	movingBlock2y = 992
	
	laserStatus = true
	keyHold = false
	
	keyintialX = 384
	keyintialY = 768

	screenshotTaken = false
	
end

function love.update(dt)
	if paused == false then
		-- check controls
		if love.keyboard.isDown("right") then
			p:moveRight()
			playerSprites:flip(false, false)
		end
		if love.keyboard.isDown("left") then
			p:moveLeft()
			playerSprites:flip(true, false)
		end
		if love.keyboard.isDown(" ") and not(hasJumped) then
			hasJumped = true
			p:jump()
		end
 
		-- update the player's position and check for map collisions
		p:update(dt, gravity, map)
    
		-- update the sprite animation
		if (p.state == "stand") then
			playerSprites:switch(1, 4, 200)
		end
		if (p.state == "moveRight") or (p.state == "moveLeft") then
			playerSprites:switch(2, 4, 120)
		end
		if (p.state == "jump") then
			playerSprites:reset()
			playerSprites:switch(3, 1, 300)
		end
		if (p.state == "fall") then
			playerSprites:reset()
			playerSprites:switch(4, 1, 300)
		end
	
		-- update the player animations
		playerSprites:update(dt)
	end
    
    -- center the camera on the player
    camera:setPosition(math.floor(p.x - width / 2), math.floor(p.y - height / 2))
	
	-- for the debug info, if the left or right control key is held down
	if love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl") then
        ctrldown = true
	else
		ctrldown = false
    end
	
	if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
		shiftdown = true
	else
		shiftdown = false
	end
	
	-- create the popup above the player's head if it is within the range
	if (p.x > 1420) and (p.x < 1490) and (p.y == 976) then
		signRead = true
	else
		signRead = false
	end
	
	-- stopping the player leave the room if the sign hasen't been "read"
	if text1display == true or done == false then
		if p.x < 1328 then
			p.x = 1328
		end
	end
	
	-- for displaying the instructions when the sign is "read"
	if text1display == true then
		if paused == false then
			timer = timer + 1
		else
			timer = timer
		end
		if done == false then
			if math.mod(timer, 5) == 0 then
				outputText = string.sub(text1, 1, -text1charcount).."_"
				text1charcount = text1charcount - 1
				if text1charcount == 0 then
					done = true
				end
			end
		end
		if timer > 350 then
			outputText = ""
			if math.mod(timer, 2) == 0 then
				movingBlock1y = movingBlock1y - 1
				movingBlock2y = movingBlock2y + 1
				if movingBlock2y == 1024 then
					text1display = false
				end
			end
		end
	end
	
	-- if the game is paused, run the code below.
	if paused == true then
		-- freeze player coordinates
		p.x = p.x 
		p.y = p.y 
		love.mouse.setVisible(true) -- set mouse as visible
		love.mouse.setGrab(false) -- unlock mouse
	else
		love.mouse.setVisible(false) -- set mouse as invisible
		love.mouse.setGrab(true) -- lock mouse
	end
	
	-- if laser is on, and the player touches it, reset back to start of the level.
	if laserStatus == true then
		if (p.x < 190) then
			if keyHold == true then
				laserStatus = false
			else
				p.x = 1552
				p.y = 900
			end
		end
	else
	end

	if (p.x < 80) and (p.y == 112) then
		dofile (outro)
		love.load()
	end


end

function love.draw()
    camera:set()
	--love.graphics.draw(backgroundLayer, 0, 0)
	
	x1 = p.x - 800
    y2 = p.y - 600
    
    -- round our x, y values
    local x, y = math.floor(p.x), math.floor(p.y)
    
    -- draw the map
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(tile1, 1280, movingBlock1y)
	love.graphics.draw(tile1, 1280, movingBlock2y)
    map:draw()	
	
    -- draw the player
    playerSprites:draw(x - p.width / 2, y - p.height / 2)
	

	if laserStatus == true then
		love.graphics.draw(laserOn, 160, 960)
	else
		love.graphics.draw(laserOff, 160, 960)
	end
	
	if keyHold ==  true then
		love.graphics.draw(key, (p.x - p.width / 2), (p.y - 43))
	else
		love.graphics.draw(key, keyintialX, keyintialY)
	end
	
	-- draw the shadow, centered on the player
	love.graphics.draw(shadow, (x - p.width) - 800, (y - p.height) - 600)
	
	-- set the current font and color
	love.graphics.setFont(mainFont) -- set font to loaded font
	love.graphics.setColor(255, 255, 255) -- set text colour to white  
	
	-- print the "PRESS UP" above the player when near the sign
	if done == false then
		if signRead == true then
			love.graphics.print("PRESS UP", (p.x - 45), (p.y - 32))
		end
    else
	end
	
	-- print the "PRESS UP" above the player when near the key to pick up
	if keyHold == false then
		if (p.x > 380) and (p.x < 425) and (p.y == 784) then
			love.graphics.print("PRESS UP", (p.x - 45), (p.y - 32))
		end
    else
	end
	
	
	
	

    camera:unset()

	
	-- print the outputText. normally will be blank
	love.graphics.print(outputText, 275, 300)
	
	-- run the code below if the game is paused, only for drawing and printing of things
	if paused == true then
		love.graphics.draw(overlay, 0, 0)
		if screenshotTaken == true then
			love.graphics.setFont(mainFont)
			love.graphics.setColor(0, 255, 255)
			love.graphics.print("SCREENSHOT TAKEN!", 305, 100)
		else
		end
		love.graphics.setColor(255, 255, 255)
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
    	
		-- debug information (will only display if DISPLAY_DEBUG == true)
	if DISPLAY_DEBUG == true then
		love.graphics.setColor(255, 255, 255)
	    local tileX = math.floor(p.x / map.tileWidth)
		local tileY = math.floor(p.y / map.tileHeight)
		love.graphics.setFont(defaultFont)
		fps = love.timer.getFPS( )
		love.graphics.print("Aventyr-game-2.lua(1.0) LOVE: 0.8.0", 5, 5)
		love.graphics.print("FPS: "..fps, 5, 20)
		love.graphics.print("VARIABLES:", 5, 50)
		if ctrldown == true then
			love.graphics.print("ctrldown = TRUE", 5, 65)
		else
			love.graphics.print("ctrldown = FALSE", 5, 65)
		end
		love.graphics.print("Player coordinates: ("..x..","..y..")", 5, 80)
		love.graphics.print("Current state: "..p.state, 5, 95)
		love.graphics.print("Current tile: ("..tileX..", "..tileY..")", 5, 110)
		if paused == true then
			love.graphics.print("paused = TRUE", 5, 125)
		else
			love.graphics.print("paused = FALSE", 5, 125)
		end
		love.graphics.print("score: NULL", 5, 140)
		if signRead == true then
			love.graphics.print("signRead = TRUE", 5, 155)
		else
			love.graphics.print("signRead = FALSE", 5, 155)
		end
		love.graphics.print("timer: "..timer, 5, 170)
		if text1display == true then
			love.graphics.print("text1display = TRUE", 5, 185)
		else
			love.graphics.print("text1display = FALSE", 5, 185)
		end
		love.graphics.print("outputText: "..outputText, 5, 200)
		if laserStatus == true then
			love.graphics.print("laserStatus = TRUE", 5, 215)
		else
			love.graphics.print("laserStatus = FALSE", 5, 215)
		end
		if keyHold== true then
			love.graphics.print("keyHold = TRUE", 5, 230)
		else
			love.graphics.print("keyHold = FALSE", 5, 230)
		end		
		love.graphics.print("GLOBAL VARIABLES:", 5, 260)
		love.graphics.print("CURRENT_LEVEL: "..CURRENT_LEVEL, 5, 275)
		love.graphics.print("CURRENT_FILE: "..CURRENT_FILE, 5, 290)
		if MUSIC_STATUS == true then
			love.graphics.print("MUSIC_STATUS = TRUE", 5, 305)
		else
			love.graphics.print("MUSIC_STATUS = FALSE", 5, 305)
		end
		if DISPLAY_DEBUG == true then
			love.graphics.print("DISPLAY_DEBUG = TRUE", 5, 320)
		else
			love.graphics.print("DISPLAY_DEBUG = FALSE", 5, 320)
		end
	end

end

-- check for keyboard key releases
function love.keyreleased(key)

	-- runs the code when the escape key is pressed
    if key == "escape" then
        if paused == false then
			paused = true
			screenshotTaken = false
		else
			paused = false
			screenshotTaken = false
		end
    end
	if key == "f2" then
		local name = string.format("%s.png", os.date("(%d-%m-%y)%H.%M.%S"))
		local s = love.graphics.newScreenshot() --ImageData
		s:mapPixel(
			function(x, y, r, g, b, a)
				return r, g, b, 255
			end
		)
		s:encode(name, "png")
		paused = true
		screenshotTaken = true
	else
	end
	
	-- if the up key is pressed, will only work when reading the sign
	if paused == false then
		if key == "up" then
			if signRead == true then
				if done == false  then
					text1display = true	
				end
			end
			if (p.x > 380) and (p.x < 425) and (p.y == 784) then
				if keyHold ==  false then
					keyHold = true
				end
			end
		end
	end
	
	-- if the right or left key is released, stop moving the player
    if (key == "right") or (key == "left") then
        p:stop()
    end
	
	-- if the space bar is released, ensure the player can't keep jumping
    if (key == " ") then
        hasJumped = false
    end
	
	-- Checks if the "d" key is pressed, then toggles the debug menu
	if key == "d" then
		if ctrldown == true then
			if shiftdown == true then
				debug.debug()
			else
				if DISPLAY_DEBUG == true then
					DISPLAY_DEBUG = false
				else
					DISPLAY_DEBUG = true
				end
			end
		end
	end
	
end

-- check for mouse clicks
function love.mousepressed(mousex, mousey, button)
	if paused == true then
		if (mousex > 320) and (mousex < 460) and (mousey > 250) and (mousey < 275) then
			if button == "l" then
				paused = false
				screenshotTaken = false
			end
		end
		if (mousex > 295) and (mousex < 485) and (mousey > 300) and (mousey < 325) then
			if button == "l" then
				dofile (menu)
				love.load()
			end
		end				
	end
end

function math.clamp(x, min, max)
  return x < min and min or (x > max and max or x)
end

-- if the window somehow gets unfocused (by alt+tab or windows+d etc.), pause the game
function love.focus(f)
	if not f then
		paused = true
	else
	end
end