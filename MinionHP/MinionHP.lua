local ver = "0.12"


function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        PrintChat("New Version Found " .. data)
        PrintChat("Downloading update, please wait...")
        DownloadFileAsync("https://raw.githubusercontent.com/RequiredGoS/Gaming-On-Steroids/master/MinionHP/MinionHP.lua", SCRIPT_PATH .. "MinionHP.lua", function() PrintChat(string.format("<font color=\"#FC5743\"><b>Script Downloaded succesfully. please 2x f6</b></font>")) return end)
    end
end
GetWebResultAsync("https://raw.githubusercontent.com/RequiredGoS/Gaming-On-Steroids/master/MinionHP/MinionHP.version", AutoUpdate)


local HpMenu = MenuConfig("Minion HP: Version: "..ver.."", "Requireds Minion HP Drawing")

HpMenu:SubMenu("sel", "Drawings")
	HpMenu.sel:Boolean("Enabled", "Enable HP Drawings", true)
		HpMenu.sel:SubMenu("select", "Select Minions")
			HpMenu.sel.select:Boolean("mcr", "Draw on Ranged Minions", true)
			HpMenu.sel.select:Boolean("mcm", "Draw on Melee Minions", true)
			HpMenu.sel.select:Boolean("mcs", "Draw on Siege Minions", true)
local color
OnDraw(function()
    if HpMenu.sel.Enabled:Value() then
        for i, minion in ipairs(minionManager.objects) do
            if GetTeam(minion) ~= myHero.team and not minion.dead then
                if GetObjectName(minion):lower():find("ranged") and not HpMenu.sel.select.mcr:Value() then return end
                if GetObjectName(minion):lower():find("melee") and not HpMenu.sel.select.mcm:Value() then return end
                if GetObjectName(minion):lower():find("siege") and not HpMenu.sel.select.mcs:Value() then return end
               	if GetObjectName(minion):lower():find("order") then color = ARGB(255,227,52,75) else color = ARGB(255,33,184,184) end
                DrawText(""..math.ceil(GetCurrentHP(minion)).."", 16, WorldToScreen(0, GetOrigin(minion)).x-15, WorldToScreen(0, GetOrigin(minion)).y-55, color)
            end
        end
    end
end)
PrintChat(string.format("<font color=\"#85EDD7\"><b>Welcome " ..GetUser().. " to Required's Minion HP Drawings.</b></font>"))