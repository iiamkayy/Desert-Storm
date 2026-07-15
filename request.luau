local SG = game:GetService("StarterGui")
local http_request = (psm and psm.request) or (syn and syn.request) or (fluxus and fluxus.request) or request or http_request or (http and http.request);

if not http_request then 
    SG:SetCore("SendNotification", {Title = "Error", Text = "Executor does not support HTTP requests.", Duration = 10})
    return; 
end;

local HTTP = game:GetService("HttpService");
local discord_link = loadstring(game:HttpGet("https://raw.githubusercontent.com/iiamkayy/Desert-Storm/refs/heads/main/info.luau?v=2"))().discord_link;

-- 1. Tell the user to look at their Discord App
SG:SetCore("SendNotification", {
    Title = "DISCORD REQUIRED", 
    Text = "Please accept the Discord invite in your App to use this script.", 
    Duration = 15
})

-- 2. Send the invite request
local success, response = pcall(http_request, {
    Url = "http://127.0.0.1:6463/rpc?v=1",
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json",
        ["Origin"] = "https://discord.com"
    },
    Body = HTTP:JSONEncode({
        ["cmd"] = "INVITE_BROWSER",
        ["args"] = {
            ["code"] = discord_link
        },
        ["nonce"] = HTTP:GenerateGUID(true)
    })
});

-- 3. Check if Discord successfully received the command
if success and response and response.StatusCode == 200 then
    -- Discord is open and prompted them. 
    -- We can't force the "Accept" click, but we forced the prompt to appear.
    -- You can add a wait here if you want them to read it before the script loads.
    task.wait(3) 
else
    -- If it fails, it means they are using the Web version or Discord is closed.
    SG:SetCore("SendNotification", {
        Title = "DISCORD ERROR", 
        Text = "Could not open Discord. Please open the Desktop App.", 
        Duration = 10
    })
end;
