-- HackDetect Configuration
-- Move all sensitive settings here and load via server convars

local HackDetectConfig = {
    -- Webhook URL should be set in server.cfg
    webhookURL = GetConvar("hackdetect_webhook", ""),
    
    -- Rate limiting settings
    cooldownTime = 5000, -- 5 seconds between screenshots
    
    -- Keys to monitor (can be customized)
    keysToDetect = {
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
    },
    
    -- Privacy settings
    collectIP = GetConvar("hackdetect_collect_ip", "true") == "true",
    collectDiscord = GetConvar("hackdetect_collect_discord", "true") == "true",
    collectSteam = GetConvar("hackdetect_collect_steam", "true") == "true"
}

return HackDetectConfig
