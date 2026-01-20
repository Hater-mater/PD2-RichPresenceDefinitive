_G.RichPresenceDefinitive = {
	mod_path = ModPath,
	save_path = SavePath,
	save_name = "RichPresenceDefinitive.txt",
	settings = {
		show_message = true,
		use_save_file = 1,
--	Overhauls tags
		tag = "",
		autotag = true,
		customtag = "Vanilla",

--	States		
		menu = "Main Menu",
		private = "Private Lobby",
		empty = "Lobby",
		lobby = "Lobby",
		ingame = "In-game",
		payday = "Payday",
		preplanning = "Preplanning",
		game_state_loud = "Loud",
		game_state_stealth = "Stealth",

--	Various		
		days = "Day",
		coma = "",
		bracket1 = "[",
		bracket2 = "]",
		players = "",
		bracket_counter = true,
		bracket_days = true,
		bracket_diffs = true,
		bracket_tag = true,
		
--	Advanced		
		tag_mode = 1,
		game_state_status = true,
		steammm_tag = true,

--	Modes		
		cs = "[Crime Spree]",
		ho = "[Holdout]",

--	Difficulties	
		ez = "E", -- Easy difficulty only reserved for overhauls that use "Easy" to name lowest diff
		nrml = "N",
		hrd = "H",
		vh = "VH",
		ovk = "OVK",
		mh = "MH",
		dw = "DW",
		ds = "DS",
		one_down_mod = "OD",
	},
}
-- Save/Load functions
function RichPresenceDefinitive:json_encode(tab, path)
	local file = io.open(path, "w+")
	if file then
		file:write(json.encode(tab))
		file:close()
	end
end

function RichPresenceDefinitive:json_decode(tab, path)
	local file = io.open(path, "r")
	if file then
		for k, v in pairs(json.decode(file:read("*all")) or {}) do
			tab[k] = v
		end
		file:close()
	end
end

function RichPresenceDefinitive:save_settings()
	local path = self.save_path..self.save_name
	self:json_encode(self.settings, path)
end

function RichPresenceDefinitive:load_settings()
	local path = self.save_path..self.save_name
	self:json_decode(self.settings, path)
end

local save_exists = io.open(RichPresenceDefinitive.save_path..RichPresenceDefinitive.save_name, "r")
if save_exists ~= nil then
	save_exists:close()
	RichPresenceDefinitive:load_settings()
else
	RichPresenceDefinitive:save_settings()
end


-- Mod menu related stuff
Hooks:Add("MenuManagerInitialize", "RichPresenceDefinitive_hook_MenuManagerInitialize", function(menu_manager)
	MenuCallbackHandler.RichPresenceDefinitive_callback_toggle = function(self, item)
		RichPresenceDefinitive.settings[item:name()] = item:value() == "on"
	end
	
	MenuCallbackHandler.RichPresenceDefinitive_callback_savefilechoice = function(self, item)
		RichPresenceDefinitive.settings.use_save_file = item:value()
	end
	
	MenuCallbackHandler.RichPresenceDefinitive_callback_tag_modechoice = function(self, item)
		RichPresenceDefinitive.settings.tag_mode = item:value()
	end	
	
	MenuCallbackHandler.RichPresenceDefinitive_callback_string = function(self, item)
		RichPresenceDefinitive.settings[item:name()] = item:value()
	end
	
	MenuCallbackHandler.RichPresenceDefinitive_callback_save = function(self, item)
		RichPresenceDefinitive:save_settings()
	end

	MenuHelper:LoadFromJsonFile(RichPresenceDefinitive.mod_path.."menu/general_options.txt", RichPresenceDefinitive, RichPresenceDefinitive.settings)
	MenuHelper:LoadFromJsonFile(RichPresenceDefinitive.mod_path.."menu/advanced.txt", RichPresenceDefinitive, RichPresenceDefinitive.settings)
	MenuHelper:LoadFromJsonFile(RichPresenceDefinitive.mod_path.."menu/custom_names_editor.txt", RichPresenceDefinitive, RichPresenceDefinitive.settings)
	MenuHelper:LoadFromJsonFile(RichPresenceDefinitive.mod_path.."menu/states.txt", RichPresenceDefinitive, RichPresenceDefinitive.settings)
	MenuHelper:LoadFromJsonFile(RichPresenceDefinitive.mod_path.."menu/difficulties.txt", RichPresenceDefinitive, RichPresenceDefinitive.settings)
	MenuHelper:LoadFromJsonFile(RichPresenceDefinitive.mod_path.."menu/modes.txt", RichPresenceDefinitive, RichPresenceDefinitive.settings)
	MenuHelper:LoadFromJsonFile(RichPresenceDefinitive.mod_path.."menu/miscellaneous.txt", RichPresenceDefinitive, RichPresenceDefinitive.settings)
	MenuHelper:LoadFromJsonFile(RichPresenceDefinitive.mod_path.."menu/tags.txt", RichPresenceDefinitive, RichPresenceDefinitive.settings)
	
	
	-- Automatically generating settings for available maps that user have
	Hooks:Add("MenuManagerBuildCustomMenus", "RichPresenceDefinitive_hook_MenuManagerBuildCustomMenus", function(menu_manager, nodes)
		RichPresenceDefinitive:load_settings()
		
		local suffixList = {
			"_prof$",
			"_day$",
			"_night$",
			"_wrapper$"
		}
		
		local ignoreSuffix = {
			["election_day"] = true
		}
		
		MenuHelper:NewMenu("RPDS_heists_options")
		MenuHelper:NewMenu("RPDS_levels_options")
		MenuHelper:NewMenu("RPDS_skirmish_options")

		--Generating settings for heists and skirmish levels
		local job_tweak = tweak_data.narrative
		for _, job_id in ipairs(job_tweak:get_jobs_index()) do
			local job_data = job_tweak.jobs[job_id]
			local job_string = job_data and managers.localization:text(job_data.name_id)
			if job_id and job_id ~= "crime_spree" and job_string ~= "" then
				if job_id and not ignoreSuffix[job_id] then
					for _, suffix in ipairs(suffixList) do
						job_id = job_id:gsub(suffix, "")
					end
				end
				-- **sigh** Since we already have "tag" for Steam status purpose I made this check to avoid conflict with Breaking Feds ID. Dumb but still
				if job_id == "tag" then
					job_id = "tag_job"
				end
				
				if RichPresenceDefinitive.settings[job_id] == nil  then
					RichPresenceDefinitive.settings[job_id] = job_string
				end
				
				local menu_id = "RPDS_heists_options"
				local custom_job_name = RichPresenceDefinitive.settings[job_id]
				
				if job_id:find("skm_") or job_id:find("skmc_") then
					menu_id = "RPDS_skirmish_options"
				end

				MenuHelper:AddInput({
					id = job_id,
					title = job_data.name_id,
					desc = "how_to",
					callback = "RichPresenceDefinitive_callback_string",
					value = custom_job_name,
					menu_id = menu_id
				})
			end
		end
		
		--Generating settings for CS levels
		local level_data = tweak_data.levels
		for _, level_id in ipairs(level_data:get_level_index()) do
			local level = level_data[level_id]
			local level_string = level and managers.localization:text(level.name_id)
			--exclude skirmish levels
			if level_id:find("skm_") or level_id:find("skmc_") then
				level = nil
			end
			if level then
				local og_level_id = level_id
				for _, suffix in ipairs(suffixList) do
					level_id = level_id:gsub(suffix, "")
				end
				if og_level_id ~= level_id then -- allow to avoid dublicating (except Election Day D3. For some fucking reason it's not working for this day even with "_skip$" suffix in suffixList)
				else
					level_id = "level_"..level_id
				if RichPresenceDefinitive.settings[level_id] == nil then
					RichPresenceDefinitive.settings[level_id] = level_string
				end

				local custom_level_name = RichPresenceDefinitive.settings[level_id]

				MenuHelper:AddInput({
					id = level_id,
					title = level.name_id,
					desc = "how_to",
					callback = "RichPresenceDefinitive_callback_string",
					value = custom_level_name,
					menu_id = "RPDS_levels_options"
				})
				end
			end
		end
		
		RichPresenceDefinitive:save_settings()

		nodes["RPDS_heists_options"] = MenuHelper:BuildMenu("RPDS_heists_options", {back_callback = "RichPresenceDefinitive_callback_save"})
		MenuHelper:AddMenuItem(nodes["custom_names_editor"], "RPDS_heists_options", "RPDS_heists_title")
		nodes["RPDS_levels_options"] = MenuHelper:BuildMenu("RPDS_levels_options", {back_callback = "RichPresenceDefinitive_callback_save"})
		MenuHelper:AddMenuItem(nodes["custom_names_editor"], "RPDS_levels_options", "RPDS_levels_title")
		nodes["RPDS_skirmish_options"] = MenuHelper:BuildMenu("RPDS_skirmish_options", {back_callback = "RichPresenceDefinitive_callback_save"})
		MenuHelper:AddMenuItem(nodes["custom_names_editor"], "RPDS_skirmish_options", "menu_cn_skirmish")
	end)
	
	
	--[[MenuCallbackHandler.RPDC_OP_info_clbk = function(self)
		local op_info_title_id
		local op_info_desc_id
		if managers.player then
			op_info_title_id = "op_info_title"
			op_info_desc_id = "op_info_desc"
		end
		
		QuickMenu:new(managers.localization:text(op_info_title_id),managers.localization:text(op_info_desc_id),{
			{
				text = "Close",
				is_cancel_button = true
			}
		},true)
	end--]]	

end)

--Loading loc files dynamically
Hooks:Add("LocalizationManagerPostInit", "RichPresenceDefinitive_LocalizationManagerPostInit", function(loc)
	local loc_path = RichPresenceDefinitive.mod_path .. "loc/"

	if file.DirectoryExists(loc_path) then
			for _, filename in pairs(file.GetFiles(loc_path)) do
				local str = filename:match('^(.*).txt$')
				if str and Idstring(str) and Idstring(str):key() == SystemInfo:language():key() then
					loc:load_localization_file(loc_path .. filename)
					break
				end
			end
		loc:load_localization_file(loc_path .. "english.txt", false)
	else
		log("Localization folder seems to be missing!")
	end
end)

