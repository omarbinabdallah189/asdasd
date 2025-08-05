local webhookURL = "https://canary.discord.com/api/webhooks/1401309308771369100/7O4mhAK5z0MoRzHD3GoTiD6apNJntSAmz8FOZIRFxxv3W_Zr-2idHV2__--oT903dfff"

RegisterNetEvent("hackdetect:requestScreenshot")
AddEventHandler("hackdetect:requestScreenshot", function(keyName)
    local src = source
    local playerName = GetPlayerName(src)
    local playerIP = GetPlayerEndpoint(src)
    local playerId = src
    local identifiers = GetPlayerIdentifiers(src)

    local license, steam, discord = "Not Found", "Not Found", "Not Found"

    for _, id in pairs(identifiers) do
        if string.find(id, "license") then license = id end
        if string.find(id, "steam") then steam = id end
        if string.find(id, "discord") then discord = id end
    end

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

    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({
        username = "HackDetect",
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end)
