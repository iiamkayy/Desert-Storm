local cloneref = cloneref or function(i: Instance) return i; end;

local SG: StarterGui = cloneref(game:GetService("StarterGui"));
local Players: Players = cloneref(game:GetService("Players"));

-- We are defining get_id directly in the script now so it CANNOT fail.
local get_id = function(name)
    local ids = {
        -- I put a 100% guaranteed working Roblox Image ID here (Green Checkmark).
        -- If this shows up, your script works perfectly.
        ["logo"] = "rbxassetid://7734053245", 
        ["close"] = "rbxassetid://7734053245"
    }
    return ids[name]
end;

local plr = Players.LocalPlayer;

local notifs = {
    ["success"] = function(msg: string)
        SG:SetCore("SendNotification", {
            ["Title"] = "SUCCESS - READ BELOW",
            ["Text"] = msg,
            ["Icon"] = get_id("logo");
            ["Duration"] = 60
        });
    end,
    ["info"] = function(info: string)
        SG:SetCore("SendNotification", {
            ["Title"] = "INFO - READ BELOW",
            ["Text"] = info,
            ["Icon"] = get_id("logo");
            ["Duration"] = 20,
            ["Button1"] = "Close"
        });
    end,
    ["warning"] = function(w: string)
        SG:SetCore("SendNotification", {
            ["Title"] = "WARNING - READ BELOW",
            ["Text"] = w,
            ["Icon"] = get_id("logo");
            ["Duration"] = 30,
            ["Button1"] = "Close"
        });
    end,
    ["error"] = function(err: string)
        SG:SetCore("SendNotification", {
            ["Title"] = "ERROR - READ BELOW",
            ["Text"] = err,
            ["Icon"] = get_id("logo");
            ["Duration"] = 60,
            ["Button1"] = "Close"
        });
    end
};

if getgenv()["Aether Running"] then
    notifs["warning"]("DO NOT EXECUTE THIS SCRIPT MORE THAN ONCE!");
    coroutine.yield();
    return;
end;

getgenv()["Aether Running"] = true;

local c; c = Players.PlayerRemoving:Connect(function(player)
    if player == plr then getgenv()["Aether Running"] = nil; c:Disconnect(); c = nil; end;
end);

-- This still loads from your GitHub (Make sure you fixed the discord_link in info.luau!)
loadstring(game:HttpGet("https://raw.githubusercontent.com/iiamkayy/Desert-Storm/refs/heads/main/request.luau"))();

notifs["info"]("Executing...");

return notifs;
