local HttpService = game:GetService("HttpService")

local JSON_URL = "https://raw.githubusercontent.com/Crack-rbx/Scripts/main/Roblox/Loader/GameList.json"

local function loadscript(ID, hub)
	if not ID then
		return nil
	end

	local success, response = pcall(function()
		return HttpService:GetAsync(JSON_URL)
	end)

	if not success then
		warn("Error retrieving the configuration:", response)
		return nil
	end

	local successDecode, data = pcall(function()
		return HttpService:JSONDecode(response)
	end)

	if not successDecode then
		warn("Invalid JSON:", data)
		return nil
	end

	local gameData = data[tostring(ID)]

	if not gameData or not gameData.hubs then
		return nil
	end

	if hub == nil or hub == "nil" then
		return gameData.hubs
	end

	for _, availableHub in ipairs(gameData.hubs) do
		if availableHub.name == hub then
			return availableHub
		end
	end

	return nil
end
