local HackDetectConfig = require 'config'

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100) -- Reduced frequency for better performance
        for key, name in pairs(HackDetectConfig.keysToDetect) do
            if IsControlJustPressed(1, key) then
                TriggerServerEvent("hackdetect:requestScreenshot", name)
            end
        end
    end
end)

RegisterNetEvent("hackdetect:takeScreenshot")
AddEventHandler("hackdetect:takeScreenshot", function(keyName, playerInfo)
    -- Remove webhook URL from client - server handles Discord communication
    exports['screenshot-basic']:requestScreenshotUpload(
        nil, -- Server will handle the webhook URL
        "files[]",
        function(data)
            if data then
                local resp = json.decode(data)
                if resp and resp.attachments and resp.attachments[1] then
                    local screenshotUrl = resp.attachments[1].url
                    TriggerServerEvent("hackdetect:uploadComplete", keyName, screenshotUrl, playerInfo)
                else
                    print("^1[HackDetect] Failed to get screenshot URL^0")
                end
            end
        end
    )
end)
