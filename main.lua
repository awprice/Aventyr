--[[                                                                         
  ####                                                                          
  ####                                                                          
 #######                                         ####                           
 #######                                         ####                          
###   ###  ###   ####   #######   #########  ########### ####   ###  ########  
###   ###  ###   ####   #######   #########  ########### ####   ###  ########  
#########  ###   #### ####   #### ###    ###     ####    ####   ###  ###   ####
#########  ###   #### ####   #### ###    ###     ####    ####   ###  ###   ####
###   ###  ###   #### ########### ###    ###     ####    ####   ###  ###       
###   ###  ########## ########### ###    ###     ####    ##########  ###       
###   ###   #######   ####        ###    ###     ####      ########  ###       
###   ###     ####      #######   ###    ###      ######      ####   ###       
###   ###     ####      #######   ###    ###      ######      ####   ###        
                                                         #######                
                                                         #######                
]]--


--[~~~~~~~~~~INFO~~~~~~~~~~]--
-- Game: Aventyr        	--
-- Creator: Alex Price  	--
-- Year: 2013           	--
-- Game Version: 1.0    	--
-- Langauge: Lua			--
-- Library: LÖVE			--
-- Library Version: 0.8.0	--
--[~~~~~~~~~~~~~~~~~~~~~~~~]--

--------------------------------
-- Scene files to load below
--------------------------------

	mainIntro = "classes/mainIntro.lua" 	-- Current Version: 1.0 DONE
	
	menu = "classes/menu.lua" 				-- Current Version: 1.0 DONE
	settings = "classes/settings.lua" 		-- Current Version: 1.0 DONE
	tutorial = "classes/tutorial.lua" 		-- Current Version: 1.0 DONE
	help = "classes/help.lua" 				-- Current Version: 1.0 DONE
	developer = "classes/developer.lua" 	-- Current Version: 1.0 DONE
	
	introOne = "classes/intro-1.lua" 		-- Current Version: 1.0 DONE
	gameOne = "classes/game-1.lua" 			-- Current Version: 1.0 DONE
	
	introTwo = "classes/intro-2.lua" 		-- Current Version: 1.0 DONE
	gameTwo = "classes/game-2.lua" 			-- Current Version: 1.0 DONE

	outro = "classes/outro.lua"				-- Current Version: 1.0 DONE

--------------------------------
-- Set location for filesystem
--------------------------------

love.filesystem.setIdentity(".aventyr") -- set the filesystem inside C:/Users/(name)/AppData/Roaming/Love/
	
--------------------------------
-- Define Global Variables below
--------------------------------

CURRENT_LEVEL = 0 -- storing current level for the resume game option in the main menu. If it is set to 0, the "Resume Game" button will not display in the Main Menu. If it is set to anything else, it will resume to the corrosponding file.
CURRENT_FILE = "NULL" -- variable for storing the current file that is open. used to ensure functions to not somehow carry over into other files.
MUSIC_STATUS = true -- stores status of the Music. This option can be changed in the settings menu
DISPLAY_DEBUG = false -- global variable for storing the state of the debug screen, so that when changing class files, it can be kept constant.

-- custom command for inside debug console for quiting
function quit()
	love.event.quit()
end

--------------------------------
-- Extra reference information
--------------------------------

--[~~~~~~~~~LEVELS~~~~~~~~~]--
--		1 = introOne  		--
--		2 = gameOne  		--
--		3 = introTwo  		--
--		4 = gameTwo  		--
--		5 = outro			--
--[~~~~~~~~~~~~~~~~~~~~~~~~]--

--------------------------------
-- Set first scene file to run
--------------------------------

dofile (mainIntro) -- default should be "mainIntro"