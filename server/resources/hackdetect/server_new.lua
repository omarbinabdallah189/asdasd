local HackDetectConfig = require 'config'

-- Rate limiting table
local lastScreenshotTime = {}

-- Validate webhook configuration
if HackDetectConfig.webhookURL == "" then
    print("^1[HackDetect] Warning: Webhook URL not configured. Set 'hackdetect_webhook' in server.cfg^0")
    return
end

RegisterNetEvent("hackdetect:requestScreenshot")
AddEventHandler("hackdetect:requestScreenshot", function(keyName)
    local src = source
    local playerId = src
    
    -- Rate limiting check
    local currentTime = GetGameTimer()
    if lastScreenshotTime[playerId] and (currentTime - lastScreenshotTime[playerId] < HackDetectConfig.cooldownTime) then
        return
    end
    
    lastScreenshotTime[playerId] = currentTime
    
    -- Get player info
    local playerName = GetPlayerName(src)
    local playerIP = HackDetectConfig.collectIP and GetPlayerEndpoint(src) or "Hidden"
    local identifiers = GetPlayerIdentifiers(src)
    
    -- Parse identifiers based on privacy settings
    local license, steam, discord = "Not Found", "Not Found", "Not Found"
    
    for _, id in pairs(identifiers) do
        if string.find(id, "license") then license = id end
        if HackDetectConfig.collectSteam and string.find(id, "steam") then steam = id end
        if HackDetectConfig.collectDiscord and string.find(id, "discord") then discord = id end
    end
    
    -- Send screenshot request to client
    TriggerClientEvent("hackdetect:takeScreenshot", src, keyName, {
        name = playerName,
        id = playerId,
        ip = playerIP,
        license = license,
        steam = steam,
        discord = discord
    })
end)

RegisterNetEvent("hackdetect:uploadComplete")
AddEventHandler("hackdetect:uploadComplete", function(keyName, screenshotUrl, playerInfo)
    local embed = {
        {
            ["color"] = 16711680,
            ["title"] = "HackDetect Screenshot",
            ["description"] = string.format(
                "**Name:** %s\n**ID:** %d\n**IP:** %s\n**Discord:** %s\n**License:** %s\n**Steam:** %s\n**Key Pressed:** %s\n**Time:** %s",
                playerInfo.name, playerInfo.id, playerInfo.ip, playerInfo.discord, playerInfo.license, playerInfo.steam, keyName, os.date("%Y-%m-%d %H:%M:%S")
            ),
            ["image"] = { ["url"] = screenshotUrl },
            ["footer"] = { ["text"] = "HackDetect System" }
        }
    }

    PerformHttpRequest(HackDetectConfig.webhookURL, function(err, text, headers)
        if err then
            print("^1[HackDetect] Webhook error: " .. err .. "^0")
        elseif text then
            local response = json.decode(text)
            if response and response.code then
                print("^1[HackDetect] Webhook response: " .. response.message .. "^0")
            end
        end
    end, 'POST', json.encode({
        username = "HackDetect",
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end)
