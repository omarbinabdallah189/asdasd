# Public Server Setup Guide - Omar's FiveM Server

## Overview
This guide will help you convert your local FiveM server to a public server that can be listed on the FiveM server browser.

## Step 1: Get Your FiveM License Key
1. Go to https://keymaster.fivem.net/
2. Sign in with your Cfx.re account
3. Click "New Server" or "Generate New Key"
4. Give your server a name (e.g., "Omar's Public Server")
5. Copy the generated license key
6. Replace `YOUR_LICENSE_KEY_HERE` in server-public.cfg with your actual key

## Step 2: Network Configuration (Port Forwarding)
### Router Configuration:
1. Access your router's admin panel (usually 192.168.1.1 or 192.168.0.1)
2. Find "Port Forwarding" or "Virtual Server" settings
3. Add these rules:
   - **TCP**: 30122 → Your PC's local IP (e.g., 192.168.1.100)
   - **UDP**: 30122 → Your PC's local IP (e.g., 192.168.1.100)

### Find Your Local IP:
- Windows: Open Command Prompt and type `ipconfig`
- Look for "IPv4 Address" under your active network adapter

## Step 3: Security Configuration
1. **Change RCON Password**: Replace `your_secure_rcon_password_here` with a strong password
2. **Update Server Password**: Consider adding `sv_password ""` for public access (empty = no password)
3. **Firewall**: Allow FiveM server through Windows Firewall

## Step 4: Server Optimization
### Update server-public.cfg with:
- Proper hostname and description
- Adjust max clients based on your internet connection
- Add server tags for better discoverability

## Step 5: Testing Your Public Server
1. **Local Test**: Start server with new config
2. **External Test**: Ask a friend to connect using your public IP
3. **FiveM Browser Test**: Check if server appears in server browser

## Step 6: Server Launch Commands
### Option 1: Use new config file
```bash
# Copy server-public.cfg to server.cfg
copy server-public.cfg server.cfg
# Then start your server normally
```

### Option 2: Direct launch with new config
```bash
# Start server with new config
FXServer.exe +exec server-public.cfg
```

## Step 7: Monitoring and Maintenance
1. **Check Server Status**: Use `status` command in server console
2. **Monitor Performance**: Watch for high CPU/memory usage
3. **Regular Updates**: Keep resources updated
4. **Player Management**: Use RCON commands for administration

## Important Notes:
- **Port Forwarding is Required**: Without it, players outside your network cannot connect
- **Static IP Recommended**: Consider setting static IP for your server PC
- **Backup Config**: Always backup your original server.cfg
- **Internet Speed**: Ensure you have sufficient upload speed (minimum 1 Mbps per player)

## Troubleshooting:
- **Server Not Listed**: Check license key and port forwarding
- **Connection Issues**: Verify firewall settings and port forwarding
- **High Ping**: Check server location and internet connection
- **Resource Errors**: Ensure all resources are properly configured

## Quick Commands:
- **Check IP**: `curl ifconfig.me` (external IP)
- **Test Port**: `telnet your-ip 30122` (from external network)
- **RCON Connect**: `rcon.connect your-ip:30122 your-password`

## Support:
If you encounter issues, check:
1. FiveM server logs
2. Router configuration
3. Windows Firewall settings
4. FiveM community forums
