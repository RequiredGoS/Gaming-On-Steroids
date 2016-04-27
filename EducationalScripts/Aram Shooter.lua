    local vers = "0.1"
    function AutoUpdate(data)
	    if tonumber(data) > tonumber(vers) then
	        PrintChat("New Version Found " .. data)
	        PrintChat("Downloading update, please wait...")
	        DownloadFileAsync("https://raw.githubusercontent.com/RequiredGoS/Gaming-On-Steroids/master/EducationalScripts/Aram%20Shooter.lua", SCRIPT_PATH .. "Aram Shooter.lua", function() PrintChat(string.format("<font color=\"#74E5D2\"><b>Script Downloaded succesfully. please 2x f6</b></font>")) return end)
	    end
    end
    GetWebResultAsync("https://raw.githubusercontent.com/RequiredGoS/Gaming-On-Steroids/master/EducationalScripts/Aram%20Shooter.version", AutoUpdate)

-- Above is the auto update function .

require("OpenPredict") -- Needed library for predictions

 -- Educational purpose
 if GetMapID() == 12 then -- if current map is not HOWLING ABYSS then script will not load

	Found = GetCastName(myHero, SUMMONER_1):lower() == "summonersnowball" or GetCastName(myHero, SUMMONER_2):lower() == "summonersnowball" -- check if Mark summoner was taken

	if GetCastName(myHero, SUMMONER_1):lower() == "summonersnowball" then   		--
		Mark = SUMMONER_1															--
	elseif																			-- This lines are to check where do we have Mark Summoner 
		GetCastName(myHero, SUMMONER_2):lower() == "summonersnowball" then			--
		Mark = SUMMONER_2															--
	end 																			--

		local AramMenu = MenuConfig("Sn", "Requireds Aram Shooter")					-- Menu in which the following submenu will be indexed
		if Found then
			AramMenu:SubMenu("Options", "Options")
				AramMenu.Options:Boolean("Enabled","Enable Auto Mark", true)        
				AramMenu.Options:Slider("SliderEnabled","Range for Mark", 1600, 400, 1600) -- 1600 default Value, 400 minimum, 1600 max value
				AramMenu.Options:Boolean("En2", "Activate Dash", true)

				AramMenu.Options:Empty("s", 0)

				AramMenu.Options:Boolean("Drawing", "Enable Drawing", true)
        		AramMenu.Options:ColorPick(Mark.."c", "Draw Color", {255, 25, 155, 175}) -- color table where user can choose drawing color
		elseif not Found then															 -- if user has not Mark Summoner, this menu will appear
			    AramMenu:SubMenu("NoOptions", "Mark Summoner not found")
				AramMenu.NoOptions:Info("n", "Mark Summoner not found")
		end 

	OnTick(function()
		Overload = { speed = math.huge, width = math.huge, range = AramMenu.Options.SliderEnabled:Value() } -- Info needed for Prediction
		MarkK = GetPrediction(GetCurrentTarget(), Overload)

			if AramMenu.Options.En2:Value() and AramMenu.Options.Enabled:Value() then -- if Enable Auto Mark and Activate Dash are ON, this will go on
				if MarkK and MarkK.hitChance >= 0.35 and not MarkK:mCollision(1) then
		    		CastSkillShot(Mark, MarkK.castPos)
		    		if Mark == READY then CastSpell(Mark) end 
				end
			elseif not AramMenu.Options.En2:Value() == true and AramMenu.Options.Enabled:Value() then -- if only Auto Mark is ON, this will go on
				if MarkK and MarkK.hitChance >= 0.35 and not MarkK:mCollision(1) then
		    		CastSkillShot(Mark, MarkK.castPos)
		    	end
		    end
	end)

	OnDraw(function()
		if AramMenu.Options.Drawing:Value() then
			DrawCircle(myHero.pos, AramMenu.Options.SliderEnabled:Value(), 1, 32, AramMenu.Options[Mark.."c"]:Value()) -- myHero.pos (Where the circle will be drawed around)
																													   -- AramMenu... Range of the Circle that user selected
																													   -- 1 -> Width
																													   -- 32 -> Quality
																													   -- Aram...[Mark.."c"]:Value() is the color that the user selected.
		end
	end)
end 


