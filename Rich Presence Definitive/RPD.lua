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
		tagless = false,
		anonymous = false,
		anonymous_tag = false,
		game_state_status = true,

--	Modes		
		cs = "[Crime Spree]",
		ho = "[Holdout]",

--	Difficulties	
		nrml = "N",
		hrd = "H",
		vh = "VH",
		ovk = "OVK",
		mh = "MH",
		dw = "DW",
		ds = "DS",
		one_down_mod = "OD",

		--Old reduntant stuff

--	Bain		
		--[[art = "Art Gallery",
		rand = "Bank Heist: Random",
		gold = "Bank Heist: Gold",
		depo = "Bank Heist: Deposit",
		cash = "Bank Heist: Cash",
		alesso = "Alesso Heist",
		cross = "Transport: Crossroads",
		harbour = "Transport: Harbour",
		train = "Transport: Train Heist",
		town = "Transport: Downtown",
		park = "Transport: Park",
		pass = "Transport: Underpass",
		cars = "Car Shop",
		dstore = "Diamond Store",
		jewels = "Jewelry Store",
		shadow = "Shadow Raid",
		cook = "Cook Off",
		gobank = "GO Bank",
		rvd = "Reservoir Dogs",

--	Classics		
		dah = "Diamond Heist",
		pig = "Slaughterhouse",
		panic = "Panic room",
		bridge = "Green Bridge",
		taxman = "Undercover",
		mercy = "No Mercy",
		feit = "Counterfeit",
		fwb = "First World Bank",
		heat = "Heat Street",
		
--	Events	
		ckr = "Cursed Kill Room",
		lab = "Lab Rats",
		prison = "Prison Nightmare",
		shn = "Safehouse Nightmare",

--	Miscellaneous		
		tut1 = "Tutorial - Stealth",
		tut2 = "Tutorial - Loud",
		relax = "Safehouse",
		combat = "Safehouse Raid",

--	Hector
		fs = "Firestarter",
		rats = "Rats",
		wd = "Watchdogs",

--	Jimmy		
		boil = "Boiling Point",
		station = "Murky Station",

--	Jiu Feng and Others	
		dragon = "Dragon Heist",
		sand = "The Ukrainian Prisoner",
        pent = "Mountain Master",
		ranc = "Midland Ranch",
		trai = "Lost In Transit",
		corp = "Hostile Takeover",
		deep = "Crude Awakening",

--	Locke		
		deal = "Alaskan Deal",
		mount = "Beneath The Mountain",
		birth = "Birth Of Sky",
		crossing = "Border Crossing",
		crystals = "Border Crystals",
		tijuana = "Breakfast In Tijuana",
		feds = "Breakin' Feds",
		brook = "Brooklyn Bank",
		hell = "Hell's Island",
		rock = "Henry's Rock",
		auction = "Shacklethorne Auction",
		white = "White House",

--	The Butcher		
		scar = "Scarface Mansion",
		dock = "The Bomb: Dockyard",
		forest = "The Bomb: Forest",

--	The Continental		
		tenten = "Brooklyn 10-10",
		yacht = "Yacht",

--	The Dentist		
		hox = "Hoxton Breakout",
		hm = "Hotline Miami",
		ggc = "Golden Grin Casino",
		reven = "Hoxton Revenge",
		big = "Big Bank",
		diam = "The Diamond",

--	The Elephant		
		oil = "Big Oil",
		day = "Election Day",
		frame = "Framing Frame",
		biker = "The Biker Heist",

--	Vlad		
		shock = "Aftershock",
        chca = "Black Cat",
		buluc = "Buluc's Mansion",
		four = "Four Stores",
		goat = "Goat Simulator",
		mall = "Mallcrasher",
		melt = "Meltdown",
		club = "Nightclub",
		martin = "San Martin Bank",
		santa = "Santa's Workshop",
		stealing = "Stealing Xmas",
		job = "Ukrainian Job",
		xmas = "White Xmas",
		
--	ResMod and Heat
		feds_xmas = "Breakin' Feds Xmas",
		hox_xmas = "Hoxton Breakout Xmas",
		burn = "Burnout",
		wet = "Wetwork",
		dog = "Doghouse",
        junk = "Watchful Eyes",
        bluewave = "Bluewave",
		narr_friday = "Crashing Capitol",
		nightmare_lvl = "The Old Safehouse",
		skmc_mad = "DRAK R&D Laboratories",
		bex_heat = "San Martin Remixed",
		firestarter_heat = "Firestarter Remixed",
		alex_remix = "Rats Remixed",
		ukrainian_job_prof = "Ukrainian Job Remixed",
		four_stores_remixed = "Four Stores: Remixed",
		welcome_to_the_jungle_wrapper_prof_remix = "Big Oil Remixed",
		train_rant = "Train Heist: Encore",
		
--	Crackdown
		branchbank_cash_cd = "Bank Heist Cash: Cracked",
		family_cd = "Diamond Store: Cracked",
		kosugi_cd = "Shadow Raid: Cracked",
		jolly_cd = "Aftershock: Cracked",
		spa_cd = "Brooklyn 10-10: Cracked",
		no_mercy_ranted_290 = "No Mercy: Cracked",
		wwh_cd = "Alaskan Deal: Cracked",

--	OG Pack
		op_bank_gold = "Bank Heist: Gold",
		op_bank = "Bank Heist",
		op_harbour = "Transport: Harbour",
		op_park = "Transport: Park",
		op_town = "Transport: Downtown",
		op_pass = "Transport: Underpass",
		op_cross = "Transport: Crossroads",
		op_watchdogs = "Watchdogs",
		op_ukrainian = "Ukrainian Job",
		op_fire = "Firestarter",
		op_rats = "Rats",
		op_frame = "Framing Frame",
		op_oil = "Big Oil",
		op_election = "Election Day",
		op_mia = "Hotline Miami",
		op_hox = "Hoxton Breakout",
		op_peta = "Goat Simulator",
		op_born = "Birth Of The Sky",
		op_kenaz = "Golden Grin Casino",
		op_rvd = "Reservoir Dogs",
		op_kosugi = "Shadow Raid",

--	Custom
		ghill = "All Ghilled Up",
		zm_kino =					"Kino Der Minetoten",
		zm_house =					"Zombie House",
		broken_arrow =			"Broken Arrow",
		zm_the_forest =			"Wald Der Untoten",
		hb_zombies =	"Zombie Breakout",
		zm_arena =					"Zombies Arena",
		zm_dah =					"Garnet Group Tower",			
		tlhs = "The Late Holiday Special",
		virtual =					"Ready Player None",
		mc_jewlerystore =			"Jewelry Crafters",
		mcparkour =				"Simple Fun Platforming",
		eclipse =					"Project Eclipse", 
		eclipse_research_facility = "Project Eclipse: Eclipse Research Facility",
		ascension =				"Project Eclipse: Ascension",
		infinitebank =				"First World Tower",
		heist_runner =				"Diamond Runners",
		fourmorestores =		"Four More Stores",
		daymare =					"Hells Nightmare",
		tonisn1 =					"Grand Harvest",
		ub =		"Underground_Bargains",
		red_money =				"Red Money",
		lpb = "Local Postal Bank",
		hidden_vault =				"Hidden Vault", 
		prove = "Proving Grounds",        
		stalk = "Stalk Fraud",
		spawner = "Enemy Spawner",
		funds = "Election Funds",
		south = "Harvest & Trustee: Southern Branch",
		north = "Harvest & Trustee: Northern Branch",
		csoffice = "Office Strike",
		dwn = "Deep Inside",
		snp = "Sniper Assassin",
		trop = "Tropical Treasure",
		toncont = "Armored Transport: Atrium Redux",
		tonis2 = "Triple Threat",
		hardware_store = "Hardware Store",
		avalonshadow = "Avalon's Shadow",
		jambank = "The Botched Bank Heist",
		vrc = "A Very Richie Christmas",
		tonmapjam22n = "Hard Cash",
		despacito2redux = "A Strange Underpass",
		just_uno = "Legally I Cannot Call This UNO",
		just_uno_comfy = "LICCT UNO Comfy Edition",
		physics = "Boworks",
		parable = "The Pain Parable",
		santa_pain = "The Late Holiday Special",
		alley = "Armsdeal: Alleyway",
		cargo = "Cragoship Raid",
		raiders = "Safehouse Raiders",
		lotus = "Golden Lotus Bank",
		liang = "An End To Liang",
		knock = "Knockover: Jewelry Store",
		rogue = "Rogue Company",
		blood = "Blood Money",
		fuel = "Fueled Feud",
		triad = "Triad Takedown Yacht Heist",
		lit = "California Heat",
		lit_bonus = "Almir's Games",
		gensecraid = "GenSec HQ Raid",
		bnktower = "GenSec H.I.V.E",
		skmc_ovengrill = "Ovengrill Hardware",
		ganado = "The Village",
		shore_deal_bank = "Shore Deal Bank",
		agencyrun = "Rundown Agency",
		ahop = "A House Of Pleasure",
		constantine_mobsterclub_nar = "Aurora Club",
		constantine_butcher_nar = "Butchers Bay",
		rusd = "Cold Stones",
		deadcargo = "Deadly Cargo",
		constantine_apartment_nar = "Concrete Jungle",
		crimepunish = "Crime And Punishment",
		constantine_mex_nar = "End Of An Era",
		flatline_nar = "Flatline",
		constantine_harbor_nar = "Harboring A Grudge",
		Hunter_narrative = "Hunter And Hunted",
		rusw = "Scorched Earth",
		constantine_smackdown_nar = "Smackdown",
		constantine_clubhouse_nar = "Smugglers Den",
		constantine_bank_nar = "The Pacific Bank",
		ttr_yct_nar = "Triad Takedown",
		constantine_smackdown2_nar = "Truck Hustle",
		constantine_ondisplay_nar = "On Display",
		constantine_policestation_nar = "Precinct Raid",
		constantine_mansion_nar = "Kozlov's Mansion",
		constantine_gunrunnerclubhouse_nar = "Gunrunner Clubhouse",
		constantine_gold_nar = "Golden Shakedown",
		constantine_restaurant_nar = "Blood In The Water",
		constantine_wintersniper_nar = "In The Crosshairs",
		constantine_murkyairport_nar = "Murky Airport",
		constantine_resort_nar = "Scarlett Resort",
		constantine_penthouse_nar = "Penthouse Crasher",
		constantine_jungle_nar = "Welcome To The Jungle",
		constantine_cart_con_nar = "Cartel Transport: Construction Site",
		constantine_cart_dwn_nar = "Cartel Transport: Downtown",
		constantine_cart_train_nar = "Cartel Transport: Train",
		constantine_dwtd_nar = "Dance With The Devil",
		constantine_suburbia_nar = "Early Birds",
		constantine_fiesta_nar = "Fiesta",
		constantine_yacht_nar = "Showdown",
		--]]
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
	
	MenuCallbackHandler.heist_save = function(self, item)
		RichPresenceDefinitive.settings[item:name()] = item:value()
	end
	
	MenuCallbackHandler.use_save_file = function(self, item)
		RichPresenceDefinitive.settings.use_save_file = item:value()
	end
	
	MenuCallbackHandler.menu_save = function(self, item)
		RichPresenceDefinitive.settings.menu = item:value()
	end

	MenuCallbackHandler.private_save = function(self, item)
		RichPresenceDefinitive.settings.private = item:value()
	end
	
	MenuCallbackHandler.empty_save = function(self, item)
		RichPresenceDefinitive.settings.empty = item:value()
	end
	
	MenuCallbackHandler.lobby_save = function(self, item)
		RichPresenceDefinitive.settings.lobby = item:value()
	end
	
	MenuCallbackHandler.ingame_save = function(self, item)
		RichPresenceDefinitive.settings.ingame = item:value()
	end
	
	MenuCallbackHandler.payday_save = function(self, item)
		RichPresenceDefinitive.settings.payday = item:value()
	end
	
	MenuCallbackHandler.preplanning_save = function(self, item)
		RichPresenceDefinitive.settings.preplanning = item:value()
	end
	
	MenuCallbackHandler.game_state_loud_save = function(self, item)
		RichPresenceDefinitive.settings.game_state_loud = item:value()
	end
	
	MenuCallbackHandler.game_state_stealth_save = function(self, item)
		RichPresenceDefinitive.settings.game_state_stealth = item:value()
	end
	
	MenuCallbackHandler.customtag_save = function(self, item)
		RichPresenceDefinitive.settings.customtag = item:value()
	end

	MenuCallbackHandler.days_save = function(self, item)
		RichPresenceDefinitive.settings.days = item:value()
	end
	
	MenuCallbackHandler.coma_save = function(self, item)
		RichPresenceDefinitive.settings.coma = item:value()
	end

	MenuCallbackHandler.bracket1_save = function(self, item)
		RichPresenceDefinitive.settings.bracket1 = item:value()
	end
	
	MenuCallbackHandler.bracket2_save = function(self, item)
		RichPresenceDefinitive.settings.bracket2 = item:value()
	end
	
	MenuCallbackHandler.players_save = function(self, item)
		RichPresenceDefinitive.settings.players = item:value()
	end	

	MenuCallbackHandler.cs_save = function(self, item)
		RichPresenceDefinitive.settings.cs = item:value()
	end
	
	MenuCallbackHandler.ho_save = function(self, item)
		RichPresenceDefinitive.settings.ho = item:value()
	end

	MenuCallbackHandler.nrml_save = function(self, item)
		RichPresenceDefinitive.settings.nrml = item:value()
	end
	
	MenuCallbackHandler.hrd_save = function(self, item)
		RichPresenceDefinitive.settings.hrd = item:value()
	end
	
	MenuCallbackHandler.vh_save = function(self, item)
		RichPresenceDefinitive.settings.vh = item:value()
	end
	
	MenuCallbackHandler.ovk_save = function(self, item)
		RichPresenceDefinitive.settings.ovk = item:value()
	end
	
	MenuCallbackHandler.mh_save = function(self, item)
		RichPresenceDefinitive.settings.mh = item:value()
	end
	
	MenuCallbackHandler.dw_save = function(self, item)
		RichPresenceDefinitive.settings.dw = item:value()
	end

	MenuCallbackHandler.ds_save = function(self, item)
		RichPresenceDefinitive.settings.ds = item:value()
	end
	
	MenuCallbackHandler.one_down_mod_save = function(self, item)
		RichPresenceDefinitive.settings.one_down_mod = item:value()
	end
	
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
					callback = "heist_save",
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
					callback = "heist_save",
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

