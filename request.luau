local http_request = (psm and psm.request) or (syn and syn.request) or (fluxus and fluxus.request) or request or http_request or (http and http.request);
if not http_request then return; end;

local cloneref = cloneref or function(i: Instance) return i; end;

local HTTP = cloneref(game:GetService("HttpService"));

-- Notice I added ?v=2 at the very end of the link below!
local discord_link = loadstring(game:HttpGet("https://raw.githubusercontent.com/iiamkayy/Desert-Storm/refs/heads/main/info.luau?v=2"))().discord_link;

pcall(http_request, {
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
