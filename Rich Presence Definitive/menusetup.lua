local function save_tag(tag)
	RichPresenceDefinitive.settings.tag = tag
	RichPresenceDefinitive:save_settings()
end

if RichPresenceDefinitive.settings.autotag then
local current_key = NetworkMatchMakingSTEAM._BUILD_SEARCH_INTEREST_KEY
local standard_str = 'NetworkMatchMakingSTEAM._BUILD_SEARCH_INTEREST_KEY = \"'
local gold_detected = false -- fucking crutch
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

local function set_tag(tag, mod_key)
	if current_key == mod_key then
		save_tag(tag)
		gold_detected = true
	end
end

-- Restoration Mod
if SC then
	dohttpreq("https://raw.githubusercontent.com/payday-restoration/restoration-mod/gold/lua/sc/network/base/networkmanager.lua", function(page)
		set_tag("ResMod", find_key(page, standard_str))
	end)
	
	dohttpreq("https://raw.githubusercontent.com/payday-restoration/restoration-mod/dev/lua/sc/network/base/networkmanager.lua", function(page)
		if not gold_detected then
			set_tag("ResMod Dev", find_key(page, standard_str))
		end
	end)
end

-- Hyper Heisting
if PD2THHSHIN then
--MM check disabled because both branches use same key
--dohttpreq("https://raw.githubusercontent.com/fuglore/PD2-Hyper-Heisting/master/lua/networking/networkmatchmakingsteam.lua", function(page)
--	set_tag("Hyper Heisting", find_key(page, standard_str))
--end)
	save_tag("Hyper Heisting")
end

-- Crackdown
if deathvox then
	save_tag("Crackdown")
	dohttpreq("https://raw.githubusercontent.com/Crackdown-PD2/deathvox/master/coredeathvox.lua", function(page)
		--set_tag("Crackdown", find_key(page, 'deathvox.mm_key_default = \"'))
		set_tag("Crackdown Dev", find_key(page, 'deathvox.mm_key_overhaul = \"'))
	end)
end

-- Classic Heisting
if ch_settings then
	save_tag("Classic Heisting")
	dohttpreq("https://raw.githubusercontent.com/gorgbus/Classic-Heisting-Reborn/main/Classic%20Heisting/states/menumainstate.lua", function(page)
		local mod_key = "payday2_classic_heisting_" .. find_key(page, '_G._new_version = \"')
		--set_tag("Classic Heisting", mod_key)
		set_tag("Classic Heisting U24 Mode", mod_key .. "u24")
	end)
end

-- Streamlined Heisting
if StreamHeist then
	save_tag("Streamlined Heisting")
--[[dohttpreq("https://raw.githubusercontent.com/segabl/pd2-streamlined-heisting/master/mod.txt", function(page)
	local ext = "_sh_v" .. find_key(page, '"version" : \"')
	local mod_key = current_key:gsub(ext, "") .. ext
	set_tag("Streamlined Heisting", mod_key)
end)--]]

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

-- Original Pack
if OriginalPackOptions then
	save_tag("Original Pack")
end

--Eclipse
if EclipseDebug or Eclipse then
	save_tag("Eclipse")
	--local ext_main = "_eclipse_main"
	local ext_dev = "_eclipse_dev"
	--local mod_key_main = current_key:gsub(ext_main, "")..ext_main
	local mod_key_dev = current_key:gsub(ext_dev, "")..ext_dev
	--set_tag("Eclipse", mod_key_main)
	set_tag("Eclipse Dev", mod_key_dev)	
end

--Need add MM check during Heat release (nvm it's fucking DEAD)
if heat then
	save_tag("HEAT")
end

if current_key == "NQR" then
	save_tag("NQR")
end

--BeardLib editor just in case
if BLE and BLE:RunningFix() then
	save_tag("BeardLib Editor")
end

else save_tag(tostring(RichPresenceDefinitive.settings.customtag))
end