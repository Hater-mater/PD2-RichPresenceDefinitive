
	if RequiredScript == "lib/managers/platformmanager" then
		core:module("PlatformManager")

		local set_rich_presence_original = WinPlatformManager.set_rich_presence
		function WinPlatformManager:set_rich_presence(name, ...)
			set_rich_presence_original(self, name or self._current_rich_presence, ...)

			if SystemInfo:distribution() == Idstring("STEAM") then
				-- Default config
				local display = "#raw_status" --"#DisplayMe"
				local group_key = ""
				local group_count = ""

				local game_state = "menu"
				local game_mode = ""
				local game_heist = ""
				local game_heistday = ""
				local game_difficulty = ""
				
				if self._current_rich_presence ~= "Idle" then
					if Global.game_settings.permission == "private" and not Global.game_settings.single_player then
						game_state = "private"
					else
						-- Handle Steam RP Grouping
						if not Global.game_settings.single_player then
							if managers.network.matchmake and managers.network.matchmake.lobby_handler then
								group_key = managers.network.matchmake.lobby_handler:id()
							end

							local session = managers.network:session()
							group_count = tostring(session and #session:all_peers() or 1)
						end

						-- Determine game state
						if _G.game_state_machine and (_G.game_state_machine:current_state_name() == "menu_main" or _G.game_state_machine:current_state_name() == "ingame_lobby_menu") then
							game_state = "lobby"
						elseif self._current_rich_presence == "SPEnd" or self._current_rich_presence == "MPEnd" then
							game_state = "payday"
						else
							game_state = "playing"
						end

						-- Popululate gamemode, heist and difficulty
						if managers.crime_spree and managers.crime_spree:is_active() then		-- Crime Spree
							game_mode = "crime_spree"
							game_heist = self:get_current_level_id()
							local spree_lvl = managers.crime_spree:server_spree_level()
							game_difficulty = spree_lvl and managers.money:add_decimal_marks_to_string(tostring(spree_lvl)) or "(N/A)"
						elseif managers.skirmish and managers.skirmish:is_skirmish() then		-- Holdout
							game_mode = "skirmish"
							game_heist = self:get_current_level_id()
							game_difficulty = string.format("%i/%i", managers.skirmish:current_wave_number() or 1, tweak_data and #tweak_data.skirmish.ransom_amounts or 9)
						elseif managers.job:has_active_job() then								-- Heists
							game_heist = self:get_current_job_id()

							if #(managers.job:current_job_chain_data() or {}) > 1 then
								game_mode = "heist_chain"
								game_heistday = tostring(managers.job:current_stage() or "")
							else
								game_mode = "heist"
							end

							game_difficulty = tweak_data and tweak_data:index_to_difficulty(managers.job:current_difficulty_stars() + 2) or Global.game_settings.difficulty or "easy"
						else
							-- Overwrite game state if nothing is selected
							game_state = "lobby_no_job"
						end
					end
				end

				-- Send our data to Steam
				Steam:set_rich_presence("steam_display", display)		-- Currently not usable, only Overkill can setup required localized strings here...
				Steam:set_rich_presence("steam_player_group", group_key)
				Steam:set_rich_presence("steam_player_group_size", group_count)

				Steam:set_rich_presence("game:state", game_state)
				Steam:set_rich_presence("game:mode", game_mode)
				Steam:set_rich_presence("game:heist", game_heist)
				Steam:set_rich_presence("game:heist_day", game_heistday)
				Steam:set_rich_presence("game:difficulty", game_difficulty)

				Steam:set_rich_presence("status", self:build_status_string(display, game_state, game_mode, game_heist, game_heistday, game_difficulty, group_count))
			end
		end

		local suffixList = {
			"_prof$",
			"_day$",
			"_night$",
			"_wrapper$",
			"^skm_"
		}
		local ignoreSuffix = {
			["election_day"] = true
		}

		function WinPlatformManager:get_current_job_id()
			local job_id = managers.job:current_job_id()

			if job_id and not ignoreSuffix[job_id] then
				for _, suffix in ipairs(suffixList) do
					job_id = job_id:gsub(suffix, "")
				end
			end

			return job_id or "UNKNOWN"
		end

		function WinPlatformManager:get_current_level_id()
			local level_id = Global.game_settings.level_id

			if level_id and not ignoreSuffix[level_id] then
				for _, suffix in ipairs(suffixList) do
					level_id = level_id:gsub(suffix, "")
				end
			end

			return level_id or self:get_current_job_id()
		end
			
			

		function WinPlatformManager:build_status_string(display, state, mode, heist, day, difficulty, group_count)
			
			RPDC = _G.RichPresenceDefinitive
		
			if string.len(tostring(RPDC.settings.players)) > 0 then
				gap = " "
			else
				gap = ""
			end

			if string.len(tostring(RPDC.settings.days)) > 1 then
				gap2 = " "
			else
				gap2 = ""
			end
			
			BRACKET_LEFT_TAG = RPDC.settings.bracket1
			BRACKET_RIGHT_TAG = RPDC.settings.bracket2

			if RPDC.settings.bracket_counter then
				BRACKET_LEFT_1 = RPDC.settings.bracket1
				BRACKET_RIGHT_1 = RPDC.settings.bracket2
			else
				BRACKET_LEFT_1 = ""
				BRACKET_RIGHT_1 = ""
			end
			
			if RPDC.settings.bracket_days then
				BRACKET_LEFT_2 = RPDC.settings.bracket1
				BRACKET_RIGHT_2 = RPDC.settings.bracket2
			else
				BRACKET_LEFT_2 = ""
				BRACKET_RIGHT_2 = ""
			end
			
			if RPDC.settings.bracket_diffs then
				BRACKET_LEFT_3 = RPDC.settings.bracket1
				BRACKET_RIGHT_3 = RPDC.settings.bracket2
			else
				BRACKET_LEFT_3 = ""
				BRACKET_RIGHT_3 = ""
			end		
		
			if RPDC.settings.comas then
				COMA = RPDC.settings.coma
			else
				COMA = ""
			end
			
			
			if Global.game_settings.one_down and RPDC.settings.one_down_mod ~= "" then 
			    ONE_DOWN_MOD = " "..RPDC.settings.one_down_mod
			else
			    ONE_DOWN_MOD = ""
			end

			if Global.game_settings.single_player then
				playerstate = ": {#Mode_%game:mode%}"
			else
				playerstate = ": {#Mode_%game:mode%}"..COMA.." "..BRACKET_LEFT_1..group_count.."/4"..gap..RPDC.settings.players..BRACKET_RIGHT_1				
			end
			
			RichPresenceDefinitive = _G.RichPresenceDefinitive

		
			if RPDC.settings.tagless and not RPDC.settings.anonymous and not RPDC.settings.anonymous_tag then
				no_tag = "{#State_%game:state%}"
			elseif not RPDC.settings.tagless and not RPDC.settings.anonymous and not RPDC.settings.anonymous_tag then
				with_tag = BRACKET_LEFT_TAG..RPDC.settings.tag..BRACKET_RIGHT_TAG.." {#State_%game:state%}"
			elseif RPDC.settings.anonymous and not RPDC.settings.anonymous_tag and not RPDC.settings.tagless then
				anonymous = " "..string.char(10).." " or string.char(10) or " "
			elseif RPDC.settings.anonymous_tag and not RPDC.settings.anonymous and not RPDC.settings.tagless then
				anonymous_tag = BRACKET_LEFT_TAG..RPDC.settings.tag..BRACKET_RIGHT_TAG
			else
				error_detected = "Too many settings in 'Advanced' are enabled (2 or more)"
			end

			local tokens = {
				["#raw_status"] =				no_tag or with_tag or anonymous or anonymous_tag or error_detected,

				["#State_menu"] =				RPDC.settings.menu,
				["#State_private"] =			RPDC.settings.private,
				["#State_lobby_no_job"] =		RPDC.settings.empty..COMA.." "..BRACKET_LEFT_1..group_count.."/4"..gap..RPDC.settings.players..BRACKET_RIGHT_1,
				
				["#State_lobby"] =				RPDC.settings.lobby..playerstate,
				["#State_playing"] =			RPDC.settings.ingame..playerstate,
				["#State_payday"] =				RPDC.settings.payday..playerstate,

				["#Mode_crime_spree"] =			RPDC.settings.cs..COMA.." {#Level_%game:heist%}"..COMA.." ".."(Lvl. %game:difficulty%)",
				["#Mode_skirmish"] =			RPDC.settings.ho..COMA.." {#Level_%game:heist%}", --RPDC.settings.ho..COMA.." {#Level_%game:heist%}"..COMA.." ".."(Wave %game:difficulty%)",
				["#Mode_heist"] =				"{#Job_%game:heist%}"..COMA.." "..BRACKET_LEFT_3.."{#Difficulty_%game:difficulty%}"..ONE_DOWN_MOD..BRACKET_RIGHT_3,
				["#Mode_heist_chain"] =			"{#Job_%game:heist%}"..COMA.." "..BRACKET_LEFT_2..RPDC.settings.days..gap2.."%game:heist_day%"..BRACKET_RIGHT_2..COMA.." "..BRACKET_LEFT_3.."{#Difficulty_%game:difficulty%}"..ONE_DOWN_MOD..BRACKET_RIGHT_3,

				["#Difficulty_easy"] =			"",
				["#Difficulty_normal"] =		RPDC.settings.nrml,
				["#Difficulty_hard"] =			RPDC.settings.hrd,
				["#Difficulty_overkill"] =		RPDC.settings.vh,
				["#Difficulty_overkill_145"] =	RPDC.settings.ovk,
				["#Difficulty_easy_wish"] =		RPDC.settings.mh,
				["#Difficulty_overkill_290"] =	RPDC.settings.dw,
				["#Difficulty_sm_wish"] =		RPDC.settings.ds,

				["#Job_short"] = 				"The Basics",
				["#Job_short1"] = 				RPDC.settings.tut1,
				["#Level_short1_stage1"] = 		"Stealth - Flash Drive",
				["#Level_short1_stage2"] = 		"Stealth  - Erasing History",
				["#Job_short2"] = 				RPDC.settings.tut2,
				["#Level_short2_stage1"] = 		"Loud - Get The Coke",
				["#Level_short2_stage2b"] = 	"Loud - Plan B",
				["#Job_chill"] = 				RPDC.settings.relax,
				["#Level_chill"] = 				RPDC.settings.relax,
				["#Job_chill_combat"] = 		RPDC.settings.combat,
				["#Level_chill_combat"] = 		RPDC.settings.combat,
				["#Job_safehouse"] = 			RPDC.settings.relax,
				["#Level_safehouse"] = 			RPDC.settings.relax,
				["#Job_haunted"] = 				RPDC.settings.shn,
				["#Level_haunted"] = 			RPDC.settings.shn,
				["#Job_branchbank"] = 			RPDC.settings.rand,
				["#Job_branchbank_gold"] = 		RPDC.settings.gold,
				["#Job_branchbank_deposit"] = 	RPDC.settings.depo,
				["#Job_branchbank_cash"] = 		RPDC.settings.cash,
				["#Level_branchbank"] = 		"Bank Heist",
				["#Job_arm"] = 					"Transport Heists",
				["#Job_arm_und"] = 				RPDC.settings.pass,
				["#Level_arm_und"] = 			RPDC.settings.pass,
				["#Job_arm_hcm"] = 				RPDC.settings.town,
				["#Level_arm_hcm"] = 			RPDC.settings.town,
				["#Job_arm_cro"] = 				RPDC.settings.cross,
				["#Level_arm_cro"] = 			RPDC.settings.cross,
				["#Job_arm_for"] = 				RPDC.settings.train,
				["#Level_arm_for"] = 			RPDC.settings.train,
				["#Job_arm_fac"] = 				RPDC.settings.harbour,
				["#Level_arm_fac"] = 			RPDC.settings.harbour,
				["#Job_arm_par"] = 				RPDC.settings.park,
				["#Level_arm_par"] = 			RPDC.settings.park,
				["#Job_watchdogs"] = 			RPDC.settings.wd,
				["#Level_watchdogs_1"] = 		"Truck Load",
				["#Level_watchdogs_2"] = 		"Boat Load",
				["#Job_watchdogs_stage2"] = 	"Boat Load",
				["#Level_watchdogs_stage2"] = 	"Boat Load",
				["#Job_election_day"] = 		RPDC.settings.day,
				["#Level_election_day_1"] = 	"Right Track",
				["#Level_election_day_2"] = 	"Swing Vote",
				["#Level_election_day_3"] = 	"Breaking Ballot",
				["#Job_alex"] = 				RPDC.settings.rats,
				["#Level_alex_1"] = 			"Cook Off",
				["#Level_alex_2"] = 			"Code for Meth",
				["#Level_alex_3"] = 			"Bus Stop",
				["#Job_framing_frame"] = 		RPDC.settings.frame,
				["#Level_framing_frame_1"] = 	"Art Gallery",
				["#Level_framing_frame_2"] = 	"Train Trade",
				["#Level_framing_frame_3"] = 	"Framing",
				["#Job_firestarter"] = 			RPDC.settings.fs,
				["#Level_firestarter_1"] = 		"Airport",
				["#Level_firestarter_2"] = 		"FBI Server",
				["#Level_firestarter_3"] = 		"Trustee Bank",
				["#Job_welcome_to_the_jungle"] = 		RPDC.settings.oil,
				["#Level_welcome_to_the_jungle_1"] = 	"Club House",
				["#Level_welcome_to_the_jungle_2"] = 	"Engine Problem",
				["#Job_hox"] = 					RPDC.settings.hox,
				["#Level_hox_1"] = 				"The Breakout",
				["#Level_hox_2"] = 				"The Search",
				["#Job_mia"] = 					RPDC.settings.hm,
				["#Level_mia_1"] = 				RPDC.settings.hm,
				["#Level_mia_2"] = 				"Four Floors",
				["#Job_peta"] = 				RPDC.settings.goat,
				["#Level_peta"] = 				"This was not the deal",
				["#Level_peta2"] = 				"Dirty work",
				["#Job_hox_3"] = 				RPDC.settings.reven,
				["#Level_hox_3"] = 				RPDC.settings.reven,
				["#Job_mus"] = 					RPDC.settings.diam,
				["#Level_mus"] = 				RPDC.settings.diam,
				["#Job_run"] = 					RPDC.settings.heat,
				["#Level_run"] = 				RPDC.settings.heat,
				["#Job_red2"] = 				RPDC.settings.fwb,
				["#Level_red2"] = 				RPDC.settings.fwb,
				["#Job_born"] = 				RPDC.settings.biker,
				["#Level_born"] = 				"Lion's Den",
				["#Level_chew"] = 				"Interception",
				["#Job_rvd"] = 					RPDC.settings.rvd,
				["#Level_rvd2"] = 				"Garnet Group Boutique",
				["#Level_rvd1"] = 				"Highland Mortuary",
				["#Job_nightclub"] = 			RPDC.settings.club,
				["#Level_nightclub"] = 			RPDC.settings.club,
				["#Job_brb"] = 					RPDC.settings.brook,
				["#Level_brb"] = 				RPDC.settings.brook,
				["#Job_flat"] = 				RPDC.settings.panic,
				["#Level_flat"] = 				RPDC.settings.panic,
				["#Job_cage"] = 				RPDC.settings.cars,
				["#Level_cage"] = 				RPDC.settings.cars,
				["#Job_pbr2"] = 				RPDC.settings.birth,
				["#Level_pbr2"] = 				RPDC.settings.birth,
				["#Job_rat"] = 					RPDC.settings.cook,
				["#Level_rat"] = 				RPDC.settings.cook,
				["#Job_ukrainian_job"] = 		RPDC.settings.job,
				["#Level_ukrainian_job"] = 		RPDC.settings.job,
				["#Job_gallery"] = 				RPDC.settings.art,
				["#Level_gallery"] = 			RPDC.settings.art,
				["#Job_glace"] = 				RPDC.settings.bridge,
				["#Level_glace"] = 				RPDC.settings.bridge,
				["#Job_sah"] = 					RPDC.settings.auction,
				["#Level_sah"] = 				RPDC.settings.auction,
				["#Job_roberts"] = 				RPDC.settings.gobank,
				["#Level_roberts"] = 			RPDC.settings.gobank,
				["#Job_tag"] = 					RPDC.settings.feds,
				["#Level_tag"] = 				RPDC.settings.feds,
				["#Job_dark"] = 				RPDC.settings.station,
				["#Level_dark"] = 				RPDC.settings.station,
				["#Level_wwh"] = 				RPDC.settings.deal,
				["#Job_wwh"] = 					RPDC.settings.deal,
				["#Job_friend"] = 				RPDC.settings.scar,
				["#Level_friend"] = 			RPDC.settings.scar,
				["#Job_man"] = 					RPDC.settings.taxman,
				["#Level_man"] = 				RPDC.settings.taxman,
				["#Job_des"] = 					RPDC.settings.rock,
				["#Level_des"] = 				RPDC.settings.rock,
				["#Job_help"] = 				RPDC.settings.prison,
				["#Level_help"] = 				RPDC.settings.prison,
				["#Job_big"] = 					RPDC.settings.big,
				["#Level_big"] = 				RPDC.settings.big,
				["#Job_cane"] = 				RPDC.settings.santa,
				["#Level_cane"] = 				RPDC.settings.santa,
				["#Job_spa"] = 					RPDC.settings.tenten,
				["#Level_spa"] = 				RPDC.settings.tenten,
				["#Job_jewelry_store"] = 		RPDC.settings.jewels,
				["#Level_jewelry_store"] = 		RPDC.settings.jewels,
				["#Job_jolly"] = 				RPDC.settings.shock,
				["#Level_jolly"] = 				RPDC.settings.shock,
				["#Job_family"] = 				RPDC.settings.dstore,
				["#Level_family"] = 			RPDC.settings.dstore,
				["#Job_arena"] = 				RPDC.settings.alesso,
				["#Level_arena"] = 				RPDC.settings.alesso,
				["#Job_pines"] = 				RPDC.settings.xmas,
				["#Level_pines"] = 				RPDC.settings.xmas,
				["#Job_kenaz"] = 				RPDC.settings.ggc,
				["#Level_kenaz"] = 				RPDC.settings.ggc,
				["#Job_cas"] = 				    RPDC.settings.ggc,
				["#Level_cas"] = 				RPDC.settings.ggc,
				["#Job_shoutout_raid"] = 		RPDC.settings.melt,
				["#Level_shoutout_raid"] = 		RPDC.settings.melt,
				["#Job_mad"] = 					RPDC.settings.boil,
				["#Level_mad"] = 				RPDC.settings.boil,
				["#Job_moon"] = 				RPDC.settings.stealing,
				["#Level_moon"] = 				RPDC.settings.stealing,
				["#Job_fish"] = 				RPDC.settings.yacht,
				["#Level_fish"] = 				RPDC.settings.yacht,
				["#Job_pal"] = 					RPDC.settings.feit,
				["#Level_pal"] = 				RPDC.settings.feit,
				["#Job_dinner"] = 				RPDC.settings.pig,
				["#Level_dinner"] = 			RPDC.settings.pig,
				["#Job_pbr"] = 					RPDC.settings.mount,
				["#Level_pbr"] = 				RPDC.settings.mount,
				["#Job_crojob1"] = 				RPDC.settings.dock,
				["#Level_crojob2"] = 			RPDC.settings.dock,
				["#Job_four_stores"] = 			RPDC.settings.four,
				["#Level_four_stores"] = 		RPDC.settings.four,
				["#Job_crojob"] = 				RPDC.settings.forest,
				["#Job_crojob2"] = 				RPDC.settings.forest,
				["#Level_crojob3"] = 			RPDC.settings.forest,
				["#Job_kosugi"] = 				RPDC.settings.shadow,
				["#Level_kosugi"] = 			RPDC.settings.shadow,
				["#Job_hvh"] = 					RPDC.settings.ckr,
				["#Level_hvh"] = 				RPDC.settings.ckr,
				["#Job_nail"] = 				RPDC.settings.lab,
				["#Level_nail"] = 				RPDC.settings.lab,
				["#Job_dah"] = 					RPDC.settings.dah,
				["#Level_dah"] = 				RPDC.settings.dah,
				["#Job_mallcrasher"] = 			RPDC.settings.mall,
				["#Level_mallcrasher"] = 		RPDC.settings.mall,
				["#Job_bph"] = 					RPDC.settings.hell,
				["#Level_bph"] = 				RPDC.settings.hell,
				["#Job_nmh"] = 					RPDC.settings.mercy,
				["#Level_nmh"] = 				RPDC.settings.mercy,
				["#Job_vit"] = 					RPDC.settings.white,
				["#Level_vit"] = 				RPDC.settings.white,
				["#Job_mex_cooking"] = 			RPDC.settings.crystals,
				["#Level_mex_cooking"] = 		RPDC.settings.crystals,
				["#Job_mex"] = 					RPDC.settings.crossing,
				["#Level_mex"] = 				RPDC.settings.crossing,
				["#Job_bex"] = 					RPDC.settings.martin,
				["#Level_bex"] = 				RPDC.settings.martin,
				["#Job_pex"] = 					RPDC.settings.tijuana,
				["#Level_pex"] = 				RPDC.settings.tijuana,
				["#Job_fex"] = 					RPDC.settings.buluc,
				["#Level_fex"] = 				RPDC.settings.buluc,
				["#Job_chas"] = 				RPDC.settings.dragon,
				["#Level_chas"] = 				RPDC.settings.dragon,
				["#Job_sand"] = 				RPDC.settings.sand,
				["#Level_sand"] =				RPDC.settings.sand,
	            ["#Job_chca"] = 				RPDC.settings.chca,
				["#Level_chca"] =				RPDC.settings.chca,
	            ["#Job_pent"] = 				RPDC.settings.pent,
				["#Level_pent"] =				RPDC.settings.pent,
				["#Job_ranc"] = 				RPDC.settings.ranc,
				["#Level_ranc"] =				RPDC.settings.ranc,
				["#Job_trai"] = 				RPDC.settings.trai,
				["#Level_trai"] =				RPDC.settings.trai,
				["#Job_corp"] = 				RPDC.settings.corp,
				["#Level_corp"] =				RPDC.settings.corp,
				
				--resmod
				["#Job_xmn_tag"] =				RPDC.settings.feds_xmas,
				["#Level_xmn_tag"] = 			RPDC.settings.feds_xmas,
				["#Job_xmn_hox"] = 				RPDC.settings.hox_xmas,
				["#Level_xmn_hox"] = 			RPDC.settings.hox_xmas,
				["#Job_int_dock_burn"] = 		RPDC.settings.burn,
				["#Level_int_dock_burn"] =		RPDC.settings.burn,
				["#Job_int_dock"] = 			RPDC.settings.wet,
				["#Level_int_dock"] = 			RPDC.settings.wet,
				["#Job_junker"] = 				RPDC.settings.dog,
				["#Level_junker"] =				RPDC.settings.dog,
				["#Job_nmh_res"] = 				RPDC.settings.mercy,
				["#Level_nmh_res"] = 			RPDC.settings.mercy,      
				["#Job_junk"] = 				RPDC.settings.junk,
				["#Level_junk"] = 			RPDC.settings.junk,
                ["#Job_bluewave"] = 			RPDC.settings.bluewave,
				["#Level_bluewave"] = 			RPDC.settings.bluewave,
				["#Job_narr_friday"] =	        RPDC.settings.narr_friday,
				["#Level_narr_friday"] =	    RPDC.settings.narr_friday,
				["#Job_nightmare_lvl"] =	    RPDC.settings.nightmare_lvl,
				["#Level_nightmare_lvl"] =	    RPDC.settings.nightmare_lvl,
				["#Job_skmc_mad"] =	    RPDC.settings.skmc_mad,
				["#Level_skmc_mad"] =	    RPDC.settings.skmc_mad,
				["#Job_street"] =	    RPDC.settings.heat,
				["#Level_street"] =	    RPDC.settings.heat,

		
				--og pack
				["branchbank_gold_prof"] = 				 RPDC.settings.op_bank_gold,
				["branchbank_prof"] = 					 RPDC.settings.op_bank,
				["branchbank_pro"] = 					 RPDC.settings.op_bank,
				["arm_fac_single"] = 					 RPDC.settings.op_harbour,
				["arm_par_single"] = 					 RPDC.settings.op_park,
				["arm_hcm_single"] = 					 RPDC.settings.op_town,
				["arm_und_single"] = 					 RPDC.settings.op_pass,
				["arm_cro_single"] = 					 RPDC.settings.op_cross,
				["watchdogs_wrapper_pro"] =				 RPDC.settings.op_watchdogs,
				["watchdogs_night"] = 					 RPDC.settings.op_watchdogs,
				["ukrainian_job_prof"] = 				 RPDC.settings.op_ukrainian,
				["firestarter_pro"] = 					 RPDC.settings.op_fire,
				["alex_pro"] = 							 RPDC.settings.op_rats,
				["framing_frame_pro"] =					 RPDC.settings.op_frame,
				["welcome_to_the_jungle_wrapper_prof"] = RPDC.settings.op_oil,
				["election_day_pro"] = 					 RPDC.settings.op_election,
				["mia_pro"] = 							 RPDC.settings.op_mia,
				["hox_pro"] = 							 RPDC.settings.op_hox,
				["peta_pro"] = 							 RPDC.settings.op_peta,
				["born_pro"] = 							 RPDC.settings.op_born,
				["kenaz_pro"] =							 RPDC.settings.op_kenaz,
				["rvd_pro"] = 							 RPDC.settings.op_rvd,
				["kosugi_pro"] = 						 RPDC.settings.op_kosugi,
				
				--custom
               
				["#Job_AllGhilliedUp"] =	               RPDC.settings.ghill,
				["#Level_AllGhilliedUp"] =	               RPDC.settings.ghill,
				["#Job_zm_kino"] =					RPDC.settings.zm_kino,
				["#Level_zm_kino"] =				RPDC.settings.zm_kino,
				["#Job_zm_house"] =					RPDC.settings.zm_house,
				["#Level_zm_hox_3"] =				RPDC.settings.zm_house,
				["#Job_broken_arrow2"] =			RPDC.settings.broken_arrow,
				["#Level_zm_broken_arrow"] =		RPDC.settings.broken_arrow,
				["#Job_zm_the_forest"] =			RPDC.settings.zm_the_forest,
				["#Level_zm_the_forest"] =			RPDC.settings.zm_the_forest,
				["#Job_Hoxton Breakout Zombies"] =	RPDC.settings.hb_zombies,
				["#Level_hox_2_zombie"] =			RPDC.settings.hb_zombies,
				["#Job_zm_arena"] =					RPDC.settings.zm_arena,
				["#Level_zm_arena"] =				RPDC.settings.zm_arena,
				["#Job_zm_dah"] =					RPDC.settings.zm_dah,
				["#Level_zm_dah"] =					RPDC.settings.zm_dah,
				["#Job_The Late Holiday Special"] = RPDC.settings.tlhs,
				["#Level_santa_pain"] =				RPDC.settings.tlhs,
				["#Job_Virtual"] =					RPDC.settings.virtual,
				["#Level_Victor Romeo"] =			RPDC.settings.virtual,
				["#Job_mc_jewlerystore"] =			RPDC.settings.mc_jewlerystore,
				["#Level_mc_jewlerystore_lvl"] =	RPDC.settings.mc_jewlerystore,
				["#Job_mcparkour"] =				RPDC.settings.mcparkour,
				["#Level_mcparkour"] =				RPDC.settings.mcparkour,
				["#Job_eclipse"] =					RPDC.settings.eclipse,
				["#Level_eclipse"] =				RPDC.settings.eclipse,
				["#Job_eclipse_research_facility"] = RPDC.settings.eclipse_research_facility,
				["#Level_the_factory"] =			RPDC.settings.eclipse_research_facility,
				["#Job_ascension"] =				RPDC.settings.ascension,
				["#Level_ascension_III"] =			RPDC.settings.ascension,
				["#Job_infinitebank"] =				RPDC.settings.infinitebank,
				["#Level_infinitebank_room"] =		RPDC.settings.infinitebank,
				["#Job_heist_runner"] =				RPDC.settings.heist_runner,
				["#Level_pk_hcm"] =					RPDC.settings.heist_runner,
				["#Job_AnotherFourStores"] =		RPDC.settings.fourmorestores,
				["#Level_lvl_fourmorestores"] =		RPDC.settings.fourmorestores,
				["#Job_daymare"] =					RPDC.settings.daymare,
				["#Level_daymare"] =				RPDC.settings.daymare,
				["#Job_tonisn1"] =					RPDC.settings.tonisn1,
				["#Level_tonisl1"] =				RPDC.settings.tonisn1,
				["#Job_tonmapjam22n"] =					RPDC.settings.tonmapjam22n,
				["#Level_tonmapjam22n"] =				RPDC.settings.tonmapjam22n,
				["#Job_Underground_Bargains"] =		RPDC.settings.ub,
				["#Level_Gambling_room"] =			RPDC.settings.ub,
				["#Job_red_money"] =				RPDC.settings.red_money,
				["#Level_red_money_stage_001"] =	RPDC.settings.red_money,
				["#Job_hidden_vault"] =				RPDC.settings.hidden_vault,
				["#Level_hidden_vault"] =			RPDC.settings.hidden_vault,
				["#Job_modders_devmap"] =		           RPDC.settings.prove,
				["#Level_modders_devmap"] =		           RPDC.settings.prove,
				["#Job_thechase"] =				           RPDC.settings.stalk,
				["#Level_thechase"] =			           RPDC.settings.stalk,
				["#Job_Zdann_Enemy_Spawner"] =             RPDC.settings.spawner,
				["#Level_Zdann_Enemy_Spawner"] =           RPDC.settings.spawner,
				["#Job_Election_Funds"] =		           RPDC.settings.funds,
				["#Level_Election_Funds"] =		           RPDC.settings.funds,
				["#Job_HarvestTrustee_SouthernBranch"] =   RPDC.settings.south,
				["Level_HarvestTrustee_SouthernBranch"] =  RPDC.settings.south,
				["#Job_Harvest and Trustee North"] =   RPDC.settings.north,
				["#Level_Harvest and Trustee North"] =   RPDC.settings.north,
				["#Job_office_strike"] =   RPDC.settings.csoffice,
				["#Level_office_strike"] =   RPDC.settings.csoffice,
				["#Job_dwn"] =   RPDC.settings.dwn,
				["#Level_dwn"] =   RPDC.settings.dwn,
				["#Job_snp"] =   RPDC.settings.snp,
				["#Level_snp"] =   RPDC.settings.snp,
				["#Job_trop"] =   RPDC.settings.trop,
				["#Level_trop"] =   RPDC.settings.trop,
				
				["#Job_TonCont"] =   RPDC.settings.toncont,
				["#Level_TonCont"] =   RPDC.settings.toncont,
				["#Job_Tonis2"] =   RPDC.settings.tonis2,
				["#Level_Tonis2"] =   RPDC.settings.tonis2,
				
				["#Job_hardware_store"] =   RPDC.settings.hardware_store,
				["#Level_hardware_store"] =   RPDC.settings.hardware_store,				
				["#Job_Armsdeal Alleyway"] =			   RPDC.settings.alley,
				["#Level_Armsdeal Alleyway"] =			   RPDC.settings.alley,
				["#Job_jambank"] = RPDC.settings.jambank,
				["#Level_jambank"] = RPDC.settings.jambank,
				["#Job_vrc"] = RPDC.settings.vrc,
				["#Level_vrc"] = RPDC.settings.vrc,
				["#Job_YouAreNeverAloneInTheDark"] =   	   RPDC.settings.cargo,
				["#Level_YouAreNeverAloneInTheDark"] =     RPDC.settings.cargo,
				["#Job_sh_raiders"] =                      RPDC.settings.raiders,
				["#Level_sh_raiders"] =                    RPDC.settings.raiders,
				["#Job_glb"] =                             RPDC.settings.lotus,
				["#Level_glb"] =                           RPDC.settings.lotus,
				["#Job_anlh"] =                            RPDC.settings.liang,
				["#Level_anlh"] =                          RPDC.settings.liang,
				["#Job_knk_jwl"] =                         RPDC.settings.knock,
				["#Level_knk_jwl"] =                       RPDC.settings.knock,
				["#Job_RogueCompany"] =                    RPDC.settings.rogue,
				["#Level_RogueCompany"] =                  RPDC.settings.rogue,
				["#Job_lit"] =                            RPDC.settings.lit,
				["#Level_lit"] =                          RPDC.settings.lit,
				["#Job_GenSec HQ Raid"] =                            RPDC.settings.gensecraid,
				["#Level_GenSec HQ Raid"] =                          RPDC.settings.gensecraid,
				["#Job_bnktower"] =                            RPDC.settings.bnktower,
				["#Level_bnktower"] =                          RPDC.settings.bnktower,
				["#Job_skmc_ovengrill"] =                            RPDC.settings.skmc_ovengrill,
				["#Level_skmc_ovengrill"] =                          RPDC.settings.skmc_ovengrill,

	            ["#Job_lit_bonus"] =                            RPDC.settings.lit_bonus,
				["#Level_lit_bonus"] =                          RPDC.settings.lit_bonus,
                ["#Job_ahop"] = RPDC.settings.ahop,
				["#Level_ahop"] = RPDC.settings.ahop,
				["#Job_constantine_mobsterclub_nar"] = RPDC.settings.constantine_mobsterclub_nar,
				["#Level_constantine_mobsterclub_nar"] = RPDC.settings.constantine_mobsterclub_nar,
				["#Job_constantine_harbor_nar"] =                            RPDC.settings.constantine_harbor_nar,
				["#Level_constantine_harbor_nar"] =                          RPDC.settings.constantine_harbor_nar,
				["#Job_Hunter_narrative"] =                            RPDC.settings.Hunter_narrative,
				["#Level_Hunter_narrative"] =                          RPDC.settings.Hunter_narrative,
				["#Job_rusw"] =                            RPDC.settings.rusw,
				["#Level_rusw"] =                          RPDC.settings.rusw,
				["#Job_constantine_smackdown_nar"] =    RPDC.settings.constantine_smackdown_nar,
				["#Level_constantine_smackdown_nar"] =    RPDC.settings.constantine_smackdown_nar,
				["#Job_constantine_clubhouse_nar"] =    RPDC.settings.constantine_clubhouse_nar,
				["#Level_constantine_clubhouse_nar"] =  RPDC.settings.constantine_clubhouse_nar,
				["#Job_constantine_bank_nar"] =                            RPDC.settings.constantine_bank_nar,
				["#Level_constantine_bank_nar"] =                          RPDC.settings.constantine_bank_nar,
				["#Job_ttr_yct_nar"] =  RPDC.settings.ttr_yct_nar,
				["#Level_ttr_yct_nar"] =  RPDC.settings.ttr_yct_nar,
				["#Job_constantine_smackdown2_nar"] =    RPDC.settings.constantine_smackdown2_nar,
				["#Level_constantine_smackdown2_nar"] =     RPDC.settings.constantine_smackdown2_nar,
				["#Job_constantine_ondisplay_nar"] =   RPDC.settings.constantine_ondisplay_nar,
				["#Level_constantine_ondisplay_nar"] =   RPDC.settings.constantine_ondisplay_nar,
				["#Job_constantine_butcher_nar"] =   RPDC.settings.constantine_butcher_nar,
				["#Level_constantine_butcher_nar"] =    RPDC.settings.constantine_butcher_nar,
				["#Job_constantine_resort_nar"] = RPDC.settings.constantine_resort_nar,
				["#Level_constantine_resort_nar"] =    RPDC.settings.constantine_resort_nar,
				["#Job_constantine_wintersniper_nar"] = RPDC.settings.constantine_wintersniper_nar,
				["#Level_constantine_wintersniper_nar"] = RPDC.settings.constantine_wintersniper_nar,
				
				["#Job_ rusd"] =                            RPDC.settings.rusd,
				["#Level_rusd"] =                          RPDC.settings.rusd,
				["#Job_deadcargo"] =   RPDC.settings.deadcargo,
				["#Level_deadcargo"] =   RPDC.settings.deadcargo,
				["#Job_constantine_apartment_nar"] =   RPDC.settings.constantine_apartment_nar,
				["#Level_constantine_apartment_nar"] =   RPDC.settings.constantine_apartment_nar,	
				["#Job_crimepunish"] =   RPDC.settings.crimepunish,
				["#Level_crimepunish"] =   RPDC.settings.crimepunish,
				["#Job_constantine_mex_nar"] = RPDC.settings.constantine_mex_nar,
				["#Level_constantine_mex_nar"] = RPDC.settings.constantine_mex_nar,	
				["#Job_flatline_nar"] =                           RPDC.settings.flatline_nar,
				["#Level_flatline_nar"] =                          RPDC.settings.flatline_nar,
				["#Job_constantine_policestation_nar"] =                            RPDC.settings.constantine_policestation_nar,
				["#Level_constantine_policestation_nar"] =                          RPDC.settings.constantine_policestation_nar,
				["#Job_constantine_mansion_nar"] =                            RPDC.settings.constantine_mansion_nar,
				["#Level_constantine_mansion_nar"] =                          RPDC.settings.constantine_mansion_nar,
				["#Job_constantine_gunrunnerclubhouse_nar"] =                            RPDC.settings.constantine_gunrunnerclubhouse_nar,
				["#Level_constantine_gunrunnerclubhouse_nar"] =                          RPDC.settings.constantine_gunrunnerclubhouse_nar,
				["#Level_constantine_gold_nar"] =  RPDC.settings.constantine_gold_nar,
				["#Job_constantine_gold_nar"] =    RPDC.settings.constantine_gold_nar,
				
				
			}

			local data = {
				["game:state"] = state,
				["game:mode"] = mode,
				["game:heist"] = heist,
				["game:heist_day"] = day,
				["game:difficulty"] = difficulty,
			}

			local s = string.format("{%s}", display or "#raw_status")

			local function populate_data(s, tokens, data, count)
				count = count or 1
				if count > 100 then
					log("Infinite loop in RP update!", "error")
					return s
				end

				if s:gmatch("%%(.+)%%") then
					for k, v in pairs(data or {}) do
						s = s:gsub("%%" .. k .. "%%", v)
					end
				end

				if s:gmatch("{(.+)}") then
					for k, v in pairs(tokens or {}) do
						local key = string.format("{%s}", k)
						if s:find(key) then
							s = s:gsub(key, populate_data(v, tokens, data, count + 1))
						end
					end
				end

				return s
			end

			s = populate_data(s, tokens, data)
			--log(string.format("Steam RP updated: %s", s))
			return s
		end

	elseif RequiredScript == "lib/managers/skirmishmanager" then
		local update_matchmake_attributes_original = SkirmishManager.update_matchmake_attributes
		function SkirmishManager:update_matchmake_attributes(...)
			update_matchmake_attributes_original(self, ...)

			if Global.game_settings.permission ~= "private" then
				--local game_difficulty = string.format("%i/%i", self:current_wave_number() or 1, tweak_data and #tweak_data.skirmish.ransom_amounts or 9)
				--Steam:set_rich_presence("game:difficulty", game_difficulty)
				if managers.platform then
					managers.platform:set_rich_presence()
				end
			end
		end
	end

	if Hooks then	-- Basegame doesn't update RP on peer count changes...
		Hooks:Add("BaseNetworkSessionOnPeerEnteredLobby", "BaseNetworkSessionOnPeerEnteredLobby_WolfHUD_RP", function(session, peer, peer_id)
			local session = managers.network:session()
			if session and Global.game_settings.permission ~= "private" then
				local group_count = tostring(session and #session:all_peers() or 1)
				Steam:set_rich_presence("steam_player_group_size", group_count)
			end
		end)

		Hooks:Add("BaseNetworkSessionOnPeerRemoved", "BaseNetworkSessionOnPeerRemoved_WolfHUD_RP", function(session, peer, peer_id, reason)
			local session = managers.network:session()
			if session and Global.game_settings.permission ~= "private" then
				local group_count = tostring(session and #session:all_peers() or 1)
				Steam:set_rich_presence("steam_player_group_size", group_count)
			end
		end)
	end
