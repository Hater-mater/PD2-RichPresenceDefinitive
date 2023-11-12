local short = MenuMainState.at_enter
function MenuMainState:at_enter(old_state)
	short(self, old_state)
	
	if RichPresenceDefinitive.settings.show_message then
	RichPresenceDefinitive.settings.show_message = false
	RichPresenceDefinitive:save_settings()
	local my_advanced_message = {
		focus_button = 1,
		title = "RPDS_greetings_title",
		text = "RPDS_greetings_desc"
	}

	local node1 = {
		text = managers.localization:text("RPDS_greetings_message_confirm")
	}
	
	my_advanced_message.button_list = {
		node1
	}

	managers.menu:show_video_message_dialog(my_advanced_message)
	end
end