FastMute = FastMute or {}

local Net = _G.LuaNetworking

function FastMute:mute(id)
	if peer(id):is_muted() then
		peer(id):set_muted(false)
		managers.chat:_receive_message(1, "FastMute", Net:GetNameFromPeerID(id) .. " was unmuted.", Color.red)
	else
		peer(id):set_muted(true)
		managers.chat:_receive_message(1, "FastMute", Net:GetNameFromPeerID(id) .. " is mutated.", Color.green)
	end
end

if Net:IsMultiplayer() and Net:IsInHeist() then
	if Net:GetNumberOfPeers() > 0 then
		local peer = managers.network._session:peer(id)
		local menu_options = {}
		for _, peer in pairs(managers.network:session():peers()) do
			menu_options[#menu_options+1] ={text = peer:name(), data = peer:id(), callback = openChat}
		end
		menu_options[#menu_options+1] = {text = "", is_cancel_button = true}
		menu_options[#menu_options+1] = {text = "Close", is_cancel_button = true}
		local muteMenu = QuickMenu:new("Fast Mute", "I want to mute...", menu_options)
		muteMenu:Show()
	else
		managers.chat:_receive_message(1, "FastMute", "You are alone in the game.", Color.red)
	end	
end