# HackDetect System - Security Fixed Version

## Overview
This is a security-enhanced version of the HackDetect system for FiveM servers that monitors key presses and takes screenshots for anti-cheat purposes.

## Security Improvements
- ✅ **Removed webhook URL from client files** - only server handles Discord communication
- ✅ **Moved sensitive configuration to server.cfg** using convars
- ✅ **Added rate limiting** - 5-second cooldown between screenshots
- ✅ **Added privacy controls** - configurable data collection
- ✅ **Added error handling** for webhook failures
- ✅ **Improved performance** - reduced client-side polling frequency

## Installation

1. **Update server.cfg** with your webhook URL:
```
set hackdetect_webhook "https://your-webhook-url.com"
set hackdetect_collect_ip "true"
set hackdetect_collect_discord "true"
set hackdetect_collect_steam "true"
```

2. **Replace the old files** with the new ones:
- Replace `server.lua` with `server_new.lua`
- Replace `client.lua` with `client_new.lua`
- Keep `config.lua` and `fxmanifest.lua`

3. **Restart your server** for changes to take effect

## Configuration Options

### Server Configuration (server.cfg)
- `hackdetect_webhook`: Discord webhook URL
- `hackdetect_collect_ip`: Collect player IP addresses (true/false)
- `hackdetect_collect_discord`: Collect Discord IDs (true/false)
- `hackdetect_collect_steam`: Collect Steam IDs (true/false)

### Code Configuration (config.lua)
- `cooldownTime`: Time between screenshots (milliseconds)
- `keysToDetect`: Keys to monitor for screenshots

## Usage
The system automatically monitors specified keys and takes screenshots when pressed, sending them to your configured Discord webhook.

## Security Notes
- Never expose webhook URLs in client-side files
- Always use server-side configuration for sensitive settings
- Consider privacy implications based on your jurisdiction
