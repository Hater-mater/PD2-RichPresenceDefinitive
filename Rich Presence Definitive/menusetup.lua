if RichPresenceDefinitive.settings.autotag then
local current_key = NetworkMatchMakingSTEAM._BUILD_SEARCH_INTEREST_KEY
local standard_str = 'NetworkMatchMakingSTEAM._BUILD_SEARCH_INTEREST_KEY = \"'
--Debug
--RichPresenceDefinitive.settings.tag = current_key:gsub("payday2", "vanilla"):gsub("_", " "):capitalize()
RichPresenceDefinitive.settings.tag = "Vanilla"
RichPresenceDefinitive:save_settings()

local function find_key(page, str)
	local _, st = string.find(tostring(page), str)
	local en, _ = string.find(tostring(page), '"', st + 1)
	local key = string.sub(tostring(page), st + 1, en - 1)
	
	return key
end

local function save_tag(tag)
	RichPresenceDefinitive.settings.tag = tag
	RichPresenceDefinitive:save_settings()
end

local function set_tag(tag, mod_key)
	if current_key == mod_key then
		save_tag(tag)
	end
end

if SC then
dohttpreq("https://raw.githubusercontent.com/payday-restoration/restoration-mod/gold/lua/sc/network/matchmaking/networkmatchmakingsteam.lua", function(page)
	set_tag("ResMod", find_key(page, standard_str))
end)
dohttpreq("https://raw.githubusercontent.com/payday-restoration/restoration-mod/dev/lua/sc/network/matchmaking/networkmatchmakingsteam.lua", function(page)
	set_tag("ResMod Dev", find_key(page, standard_str))
end)
end

if PD2THHSHIN then
--MM check disabled because both branches use same key
--dohttpreq("https://raw.githubusercontent.com/fuglore/PD2-Hyper-Heisting/master/lua/networking/networkmatchmakingsteam.lua", function(page)
--	set_tag("Hyper Heisting", find_key(page, standard_str))
--end)
	save_tag("Hyper Heisting")
	return
end

if deathvox then
dohttpreq("https://raw.githubusercontent.com/Crackdown-PD2/deathvox/master/coredeathvox.lua", function(page)
	set_tag("Crackdown", find_key(page, 'deathvox.mm_key_default = \"'))
	set_tag("Crackdown Dev", find_key(page, 'deathvox.mm_key_overhaul = \"'))
end)
end

if ch_settings then
dohttpreq("https://raw.githubusercontent.com/gorgbus/Classic-Heisting-Reborn/main/Classic%20Heisting/states/menumainstate.lua", function(page)
	local mod_key = "payday2_classic_heisting_" .. find_key(page, '_G._new_version = \"')
	set_tag("Classic Heisting", mod_key)
	set_tag("Classic Heisting U24 Mode", mod_key .. "u24")
end)
end

if StreamHeist then
dohttpreq("https://raw.githubusercontent.com/segabl/pd2-streamlined-heisting/master/mod.txt", function(page)
	local ext = "_sh_v" .. find_key(page, '"version" : \"')
	local mod_key = current_key:gsub(ext, "") .. ext
	set_tag("Streamlined Heisting", mod_key)
end)

--dohttpreq("https://raw.githubusercontent.com/segabl/pd2-streamlined-heisting/dev/mod.txt", function(page)
--	local ext = "_sh_v" .. find_key(page, '"version" : \"')
--	local mod_key = current_key:gsub(ext, "") .. ext
--	set_tag("Streamlined Heisting Dev", mod_key)
--end)

--dohttpreq("https://raw.githubusercontent.com/segabl/pd2-streamlined-heisting/zombie/mod.txt", function(page)
--	local ext = "_sh_v" .. find_key(page, '"version" : \"')
--	local mod_key = current_key:gsub(ext, "") .. ext
--	set_tag("Streamlined Heisting Zombie", mod_key)
--end)
end

if OriginalPackOptions then
	save_tag("Original Pack")
	return
end

--None MM check because main branch dead since Oct 2022
local pro = BLT.Mods:GetModByName("Eclipse")
if EclipseDebug then
	save_tag("Eclipse")
	return
elseif pro and pro:IsEnabled() then
	save_tag("Eclipse")
	return
end

--Need add MM check during Heat release
if heat then
	save_tag("HEAT")
	return
end

else save_tag(tostring(RichPresenceDefinitive.settings.customtag))
end