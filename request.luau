local SG = game:GetService("StarterGui")
local http_request = (psm and psm.request) or (syn and syn.request) or (fluxus and fluxus.request) or request or http_request or (http and http.request);

if not http_request then 
    SG:SetCore("SendNotification", {Title = "Discord Error", Text = "Your executor lacks HTTP request."})
    return; 
end;

local HTTP = game:GetService("HttpService");

-- Fetch the link
local success, link = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/iiamkayy/Desert-Storm/refs/heads/main/info.luau?v=3"))().discord_link;
end);

if not success or not link then
    SG:SetCore("SendNotification", {Title = "Discord Error", Text = "Failed to load info.luau from GitHub."})
    return;
end

SG:SetCore("SendNotification", {Title = "Discord Debug", Text = "Got link: " .. tostring(link)})

-- Try to invite
local s, r = pcall(http_request, {
    Url = "http://127.0.0.1:6463/rpc?v=1",
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json",
        ["Origin"] = "https://discord.com"
    },
    Body = HTTP:JSONEncode({
        ["cmd"] = "INVITE_BROWSER",
        ["args"] = {
            ["code"] = link
        },
        ["nonce"] = HTTP:GenerateGUID(true)
    })
});

if s and r and r.StatusCode == 200 then
    SG:SetCore("SendNotification", {Title = "Discord Debug", Text = "Success! Check your Discord app."})
else
    SG:SetCore("SendNotification", {Title = "Discord Debug", Text = "Discord app didn't respond. Is it open?"})
end
