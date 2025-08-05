local keysToDetect = {
    [45] = "INSERT",
    [121] = "F10",
    [119] = "F8",
    [115] = "F4",
    [120] = "F9",
    [46] = "DELETE",
    [118] = "F7",
    [36] = "HOME",
    [116] = "F5",
    [117] = "F6",
    [113] = "F2",
    [112] = "F1",
    [54] = "RIGHTSHIFT"
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for key, name in pairs(keysToDetect) do
            if IsControlJustPressed(1, key) then
                TriggerServerEvent("hackdetect:requestScreenshot", name)
            end
        end
    end
end)

RegisterNetEvent("hackdetect:takeScreenshot")
AddEventHandler("hackdetect:takeScreenshot", function(keyName, playerInfo)
    exports['screenshot-basic']:requestScreenshotUpload(
        "https://canary.discord.com/api/webhooks/1401309308771369100/7O4mhAK5z0MoRzHD3GoTiD6apNJntSAmz8FOZIRFxxv3W_Zr-2idHV2__--oT903dfff",
        "files[]",
        function(data)
            local resp = json.decode(data)
            local screenshotUrl = resp.attachments[1].url
            TriggerServerEvent("hackdetect:uploadComplete", keyName, screenshotUrl, playerInfo)
        end
    )
end)
