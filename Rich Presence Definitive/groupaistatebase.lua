-- Update Stealth/Loud status
Hooks:PostHook(GroupAIStateBase, "set_whisper_mode", "send_whisper_mode_data_to_rich_presence", function (self, enabled)
	if RichPresenceDefinitive.settings.game_state_status then
		managers.platform:set_rich_presence()
	end
end)